Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 49061 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 08 Oct 2018 22:27:02 UTC
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-ve1eur01on0050.outbound.protection.outlook.com [104.47.1.50])
	by mail.openembedded.org (Postfix) with ESMTP id 3189C7456D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Oct 2018 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PkbsXtH661cYui7DBAw8PiYhWGUDLUwVSZXnFw0JLog=;
	b=gnnbKfiysfIvlLzec9gvSPRizlla0mHPdZbHgIkc9P+ry5RBWvempryacdPMS/372m/MHvabRvqe+CQF/omSNGFZ4rXzo+OFfXkrq2TJ8M2NH5utJyBPCMxkNhI/MMHdWyZtk4LrmCWEh6ZOyam2Pt0cyGqIgzWgKeSKZYvJanQ=
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (20.176.243.26) by
	AM6PR03MB4488.eurprd03.prod.outlook.com (20.177.34.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Mon, 8 Oct 2018 08:15:11 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b]) by
	AM6PR03MB3832.eurprd03.prod.outlook.com
	([fe80::4117:4dd2:d53a:645b%4]) with mapi id 15.20.1207.024;
	Mon, 8 Oct 2018 08:15:11 +0000
From: =?utf-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bbv.ch>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel][PATCH v2 2/3] fetch2/git: explicitly show the
	decision logic to select the source in code
Thread-Index: AQHUXt8I8SLVT1WuBEiQC0ehgCysQA==
Date: Mon, 8 Oct 2018 08:15:11 +0000
Message-ID: <20181008081455.16384-3-urs.fassler@bbv.ch>
References: <20181008081455.16384-1-urs.fassler@bbv.ch>
In-Reply-To: <20181008081455.16384-1-urs.fassler@bbv.ch>
Accept-Language: de-CH, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.19.0
x-clientproxiedby: HE1PR07CA0012.eurprd07.prod.outlook.com
	(2603:10a6:7:67::22) To AM6PR03MB3832.eurprd03.prod.outlook.com
	(2603:10a6:20b:24::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.194.183.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR03MB4488;
	6:r9r+CGWQHbsVOeX9gvI3jpqjANZuufdYbPgSaJDQOh1T7L1PiFMejXhtFd2fuHdu1LWs7b51WujCQhHhskXJ6x3AoqEtdbtEADZb2l6voIYpt+g9JLU5uaZ/noNhYILz1eXCPoTozyaFt6K5EroXEkxKza6Bpq/jSnCEmrLhwcGX30FxH+rGfwfHsXOCsw9PORvBgbmyTDq/Xhfc61oVQNePZNcTtnH99rlVTBsd1b6tn761dzl9RcA4NbGR1Pn3swyUaEfCcQvZfZElHKSpoR7aKDoosmmbg5GGVsG1U9AFuIE0mZfd+Ixns1PxoMlGs3Ojf3gc0LeADDlsp0oEv2sgurOFaOJcNPo1qM8rSRCWKhpfRnfJ8NXsRaCVyq5qWrLI4WkIBIufAle0F+dHKndQFP0CBhB+/H+f7v8xGTkE6FL4hWkGES1HpXQ+lfER/ujnYzri4huYb1pNXXxYgg==;
	5:0M7uaH0UwohnLGkaW7Q+xwhi9EUp98rVms+YmP1G7IenouRFqXZZ9VTVWNflYzQOjbJ5ZN6r1ayxHhUP0LS40NmD89tZ1iTTjuqijVzpvgd8R8T3zbBgpDlBLccjmIqWg9OkCCbxxhyMA7xrWpiYs6BrLUizCx8TuriQvXVlyGE=;
	7:ZR2ZFP2gCZxyI7+e0jjuTMVAuyJN2F+Supm5JEpI6lHrAz1RZJgAkHnSKaRxJFXTM3DeVulcQvTSURkESe++W9Vzdn9Ukh/VQokZAD1Mteme6e1YBMTofMhOAohDzIDHs/7fK23akFRNvThZzodvS5PsLWFLd6W/5lKmgTxjLHy0fMdqBndmp8W41CRBcs5iz3QpzKHyeMjLhV8Ih1+AlJWLjbVWW2M14N2HQ8Q5MsbeyHcVPWSiCdWdqm0Aq/kI
x-ms-office365-filtering-correlation-id: 00c63586-60e6-42b8-e9c4-08d62cf62ac3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR03MB4488; 
X-MS-TrafficTypeDiagnostic: AM6PR03MB4488:|AM6PR03MB4488:|AM6PR03MB4488:
x-microsoft-antispam-prvs: <AM6PR03MB448826DDE5F6C70C121486538FE60@AM6PR03MB4488.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(126837547833334)(181554191321653)(33711482430040); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);
	SRVR:AM6PR03MB4488; BCL:0; PCL:0; RULEID:; SRVR:AM6PR03MB4488; 
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(39840400004)(396003)(376002)(346002)(136003)(189003)(199004)(14444005)(2501003)(6486002)(25786009)(8676002)(6436002)(478600001)(5640700003)(6116002)(256004)(3846002)(1076002)(99286004)(2906002)(8936002)(105586002)(2351001)(2900100001)(54906003)(81156014)(81166006)(71190400001)(71200400001)(85202003)(106356001)(5250100002)(5660300001)(6916009)(1857600001)(2616005)(36756003)(305945005)(85182001)(50226002)(7736002)(66066001)(6506007)(386003)(102836004)(66574009)(68736007)(186003)(26005)(74482002)(97736004)(86362001)(486006)(52116002)(4326008)(53936002)(76176011)(11346002)(446003)(6512007)(316002)(476003)(14454004)(33896004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR03MB4488;
	H:AM6PR03MB3832.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: mrNR3ytbUDR6smH6PIk50jfE0MApHTgAlsLSP76jQwoJGZkdi4H0IyTcFBJDNKPXQPLpByxT7mteYSlz8decYVotrJLHr4ZE+yVqxeqvhHPHf9DSWi5SsAcWIOxfiXzuHmLxXi/od8TLhAlerKkzGgnjpdjR5x4Zj83g4ThMIn6V4d5gbSXDQlXxoCtVGtBs70IzwSrkd13kfDHy5hIjAVx8Z39wykGPfMa2GyABPIzgtq0B2FzBwdeGtwQVjd8xxl5Mx2wywEHb+K37Jmj3PfwZUwjXcdCsThBeEO1JlQfpy0Oou+Dr3dpsn/Z4WC1+6lDcpLv8dlLpLLMoHbyaBk6ShdVmbD+Jn7as2drSaDw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c63586-60e6-42b8-e9c4-08d62cf62ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 08:15:11.6157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4488
X-Microsoft-Exchange-Diagnostics: 1; AM6PR03MB4488;
	23:BPEyX4oonrSHSKuiPKBI7+QtiOwGjfZW+aLXzStEhpz5Klqae4jt3vBCiUWNsIogdaTdf5glCj59nxjRfsg2RozZrKT5h5Tf3KHCjp7dd2oj0tJ9umHRR4pxd/lSvd8yfe5jYITjpMS6eRSTI3XEnA==;
	23:lP17CBGdRBas5k9VQe/fje8dlHOEruOrrZ3DIAQ3etEGyBt8of9wDwVKGErPlBmKXXkqrE3Fr9niGc/T5QDtFjNo6BCd8y5y/6Z9z7dbn0QUa8P9bddUtY86itDBWQM/S49nalgYfcMf5hr7iCmelw==
X-OriginatorOrg: bbv.ch
Subject: [PATCH v2 2/3] fetch2/git: explicitly show the decision logic to select the source in code
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 08 Oct 2018 22:27:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE439B91404552469049B707438CD73F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogVXJzIEbDpHNzbGVyIDx1cnMuZmFzc2xlckBiYnYuY2g+DQpTaWduZWQt
b2ZmLWJ5OiBQYXNjYWwgQmFjaCA8cGFzY2FsLmJhY2hAc2llbWVucy5jb20+DQotLS0NCiBsaWIv
YmIvZmV0Y2gyL2dpdC5weSB8IDcgKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5w
eSBiL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQppbmRleCAzZTM3Zjc2Zi4uNTEyNTlkZjkgMTAwNjQ0
DQotLS0gYS9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkN
CkBAIC00NzYsMTEgKzQ3NiwxMiBAQCBjbGFzcyBHaXQoRmV0Y2hNZXRob2QpOg0KICAgICAgICAg
aWYgb3MucGF0aC5leGlzdHMoZGVzdGRpcik6DQogICAgICAgICAgICAgYmIudXRpbHMucHJ1bmVk
aXIoZGVzdGRpcikNCiANCi0gICAgICAgIGlmIHVkLnNoYWxsb3cgYW5kIG9zLnBhdGguZXhpc3Rz
KHVkLmZ1bGxzaGFsbG93KSBhbmQgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCk6DQor
ICAgICAgICBjbG9uZWRpcl9pc191cF90b19kYXRlID0gbm90IHNlbGYuY2xvbmVkaXJfbmVlZF91
cGRhdGUodWQsIGQpDQorICAgICAgICBpZiBjbG9uZWRpcl9pc191cF90b19kYXRlOg0KKyAgICAg
ICAgICAgIHJ1bmZldGNoY21kKCIlcyBjbG9uZSAlcyAlcy8gJXMiICUgKHVkLmJhc2VjbWQsIHVk
LmNsb25lZmxhZ3MsIHVkLmNsb25lZGlyLCBkZXN0ZGlyKSwgZCkNCisgICAgICAgIGVsaWYgdWQu
c2hhbGxvdyBhbmQgb3MucGF0aC5leGlzdHModWQuZnVsbHNoYWxsb3cpOg0KICAgICAgICAgICAg
IGJiLnV0aWxzLm1rZGlyaGllcihkZXN0ZGlyKQ0KICAgICAgICAgICAgIHJ1bmZldGNoY21kKCJ0
YXIgLXh6ZiAlcyIgJSB1ZC5mdWxsc2hhbGxvdywgZCwgd29ya2Rpcj1kZXN0ZGlyKQ0KLSAgICAg
ICAgZWxpZiBub3Qgc2VsZi5jbG9uZWRpcl9uZWVkX3VwZGF0ZSh1ZCwgZCk6DQotICAgICAgICAg
ICAgcnVuZmV0Y2hjbWQoIiVzIGNsb25lICVzICVzLyAlcyIgJSAodWQuYmFzZWNtZCwgdWQuY2xv
bmVmbGFncywgdWQuY2xvbmVkaXIsIGRlc3RkaXIpLCBkKQ0KICAgICAgICAgZWxzZToNCiAgICAg
ICAgICAgICByYWlzZSBiYi5mZXRjaDIuVW5wYWNrRXJyb3IoIk5vIHVwIHRvIGRhdGUgc291cmNl
IGZvdW5kIiwgdWQudXJsKQ0KIA0KLS0gDQoyLjE5LjANCg0K

