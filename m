Return-Path: <vineethchowz.chowdary@xilinx.com>
X-Greylist: delayed 861 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 10 Aug 2016 19:34:52 UTC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
	(mail-sn1nam02on0088.outbound.protection.outlook.com [104.47.36.88])
	by mail.openembedded.org (Postfix) with ESMTP id C8EA7771CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 19:34:52 +0000 (UTC)
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
	(10.152.74.52) by CY1NAM02HT033.eop-nam02.prod.protection.outlook.com
	(10.152.75.70) with Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.567.7;
	Wed, 10 Aug 2016 19:20:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
	smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none; lists.openembedded.org;
	dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.83 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
	CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft
	SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.567.7
	via Frontend Transport; Wed, 10 Aug 2016 19:20:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <vineethchowz.chowdary@xilinx.com>)
	id 1bXZ3G-0006t5-18 for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2016 12:20:30 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <vineethchowz.chowdary@xilinx.com>)
	id 1bXZ3G-00041N-5o for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2016 12:20:30 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	u7AJKTRL003282 for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 12:20:29 -0700
Received: from [172.23.37.95] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <vineethchowz.chowdary@xilinx.com>)
	id 1bXZ3F-00041D-9v for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2016 12:20:29 -0700
To: <bitbake-devel@lists.openembedded.org>
From: Vineeth Karumanchi <vineethchowz.chowdary@xilinx.com>
Message-ID: <5e583ee6-4e28-1ec6-952f-0bfa38054941@xilinx.com>
Date: Thu, 11 Aug 2016 00:50:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22504.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(53754006)(189002)(2351001)(229853001)(31686004)(31696002)(19580395003)(50986999)(83506001)(15975445007)(54356999)(9786002)(19580405001)(33646002)(626004)(77096005)(63266004)(64126003)(189998001)(36756003)(2870700001)(87936001)(450100001)(106466001)(47776003)(23676002)(7846002)(65956001)(11100500001)(65806001)(4001350100001)(2906002)(8676002)(586003)(8936002)(92566002)(305945005)(110136002)(107886002)(81156014)(356003)(50466002)(81166006)(86362001)(65826006)(107986001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY1NAM02HT033; H:xsj-pvapsmtpgw01;
	FPR:; SPF:Pass; PTR:unknown-60-83.xilinx.com; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT061;
	1:Vde3iQusV1HtdfEH8yi//AoKq0hUuAmX5cgGzFPFFX9OBrXTKbjW4PuECgp7fAR12Fuui52vdoo6y+UEiBvN6xJg96nAiQLvO0yfcClWVAQ8tQvfv+QxtH295hi93cHxvvGsentc2csSY6WNV2xHd/xkHA9g0zSvYcYMw84xqhmaUJXywrQt/QLMYM7/Z82fquZUj3qHjejCGyq8z9Hapyrx++3aQ1+HU8O5mJTrEWzflp1NTCLsz+khpAh3SbSyklbwQVZdm8bOHXsrN/QJIy6DIuxcqcpcWGBmkEUnfmpaWXzKTqOqUgIHvfD/yda5A+Rq2qBRQlfCK5LmqULbzJKH5ifgVz9KRuOWqwTDTUE4rCD08ENJLIK5LxUsOJUoy/xyHwMvOWVbyiY9Qij174oT2Uzu4yS/hFe7qww+0RBQwKQlwQ/vOJWFJyWkGz+kN/3BH2xy3cO1DfomvUwhU6Qza7dTqsaXAkGtJ2x5ucbxZlPRQze3fRSdiTtix/dCaFHuPpeX2NMQnLcisLkbCiX0Ed7RzMM5VchSR7HZmaAXt2mLloIALcIwyArRjCmG
X-MS-Office365-Filtering-Correlation-Id: 6a48f47d-5cc3-4286-731d-08d3c1536506
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02HT033;
	2:H0AXxSM3bEUVsoeDZ0lbRsCKWqtKprEPDJUXNjJV33ewUhcjRtLyPwshyfTNvOmikOA4WdLeaK2YcJ5Qd9Ym34NyuW3pGPdbTWY53hTSaUGcsJhexYdEz/s+T5Lf3D1Ejcvh4lLcGMlyf30/5yBbln36ywB9lg/V8+Qgpr9D8QYZLtom/gM3ulsLZ+nU7pzt;
	3:3dmCFOZuf9jsIYPsMTxjHV8izMzamWRjVSkaa7USo9W1Zn+ErggMwJjR2mBzDHIOFCOmKtzG7EA6LessMnOwE95A6wBpELscRat0hyRu1zPLxvGjhKCX2qv3C44yzC9Kk1LpoGH1Bk7bQt35+my95neUL7oyGf/5aJwAWfB/5XWK2BtnAHgjAaDwtCOpXZk2pLn/eohhCdMcWr64Mm1FajOFMeAvWVrSvJwpAiQK5AcbN0lRxwtZ2pjD34q90rgqyIX/WjwFx30bMmoOOiT3KA==
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0; RULEID:(8251501002);
	SRVR:CY1NAM02HT033; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02HT033;
	25:W6HcGNRaHxWNAGtqM0sVHqrybw9VssFLlCdUy9Lmz1AJnawMb/h0qws/Dz8puwIcWua2/3fMa47jiLV0AkIMrLau0baXMGT5rx5FEGBHUX2EW5hxOaz8a+O6xLtPU9BquAuJR7m6vYzU1fBq9054XQM2DwqM3djQ8XfpYONyG5jXh7SiHs6BSZr/m2UpIiZIO/9Ou4Tk4e4xJB1HNF50UXeJj3ywZV36UuC7UkOfTvBp+z5p886asmQ6d7lxmC24KQiGVMsuB7jUpIdRCcXeUYI5giKZ2qRwtIcvyaHvwzoFPIdVrKAPFRMicjTYjW7e4Jm4Km0rU9fd5vnvbeLb0EwBtACBCAGRduarYekmstwhXX7kS6CQQCCXPhxoLu0tMrKm1gQMsJQRnel3nLSyMbd0mKwhDXc5MS2Jh7iQ4otthEA3JIW9nyVxcfDlq2Bz5jY4hqiFKbK3pHgG5bt6sTd2fY6rRXPfcxQRhU8/cvnTDTKnBFLWIii2hELmU0Lb6Xzys9/qTsIRWKkWtbS9B5DR/wzGu8xq+qCNrQ3sXVnMoCgaBnKcAWlwyElqHHq2+LFQs+OI+YQdeafSVo5smz15JzfoOoOF3EzRkVh+RElH+J4kIdkX9cPJCaQT2gu2IqJytW7bJ5/2xrB2aep4CM7FIKcsRbvESEOlCamFU+hXbsaSIL6iRu8It/Itly9sfdzP1z1sgQN2ZkgGPxekfUHrC1lDcoagyBeRtFL/vuXf6ZNgFKpEqmm43kdJxXBPnD28nhFIKYu7iDGKZp34DMv+wEkhwdLDIFxRGMNiHIPlLGVoIkArQ1OhVqYNSaiHUCqZcoVwvQ2eJhfv/TVy8tmURw4R8yElKlEm8+AOduS4RyRdra7vNN3hjg0EW/gf
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02HT033;
	31:3/dU6g/LXSY8eXvSE2GN1BJevr+kTVlLo6ERuEQJC2yG5EFhtOhep7aFBTJoFl2m+WSvsHqzQ8ubpC5zCXgzBy6z6tSLQdASEO+vH0cCNmm6HbNjTTqsP9KJ/O3Yrty3bcTvjZTccYu67I14KDIO9q2uioYphdLmp6UJvTjSJ2FobEQ3YgjK+fJWZgMBd7x+MXPdxUskyx8cLuODabjDJdL8e7SAOkpYkSyKLGgbfsE=;
	20:Me+91fpYf/4USsxwYGZDal4H9XYF5Lr528rC1ebv0p3BIKuGyZg5/LqC31UBylah5pEsKUQdTLQPtpIxn3HM06xAafCpyYvA0u9XC5zHCcyn46p9mOiEcdzl+lkVsPiKnjMVc69ofK1CqpSWBBQ8lHznxoRBMnt/BH8UOICV+pZV03WoZtelf1RnEjtVqRERSSlgPGDjGzsxBQEVTUPgzC88Loa09g2e8XDCyhDt8xIUe7lHr5F5VktaXHfDb5CB3eAhaWIyyarxz6GBmhuzVTCWCuVz6BhIcv9cqtJTli9bU6B/y0LoS257sB1iptxcvO7X1cYa7s2FBhyjsXQy4ZzVFUzq9bZGh4UDnrj1RwM5YgaSqShXk7hgmgIY7xomydHLqwBbzLLdpKJxix4+c3NNy6Ufrg3nHdu/xxb7nGJdWO48o/OFv0f+JZ4We8FSi9dBFfl1kmS8AKD42WMHRKl6jMHeEsJycKC6++TnwSj3Ucd4ZwcQJmUQAmO0i+rh
X-Microsoft-Antispam-PRVS: <ec99123f0f79448ea6a6b8ecac72abd4@CY1NAM02HT033.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278021516957215);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040168)(601004)(2401047)(8121501046)(5005006)(13023025)(13017025)(13018025)(13024025)(13015025)(3002001)(10201501046)(6055026);
	SRVR:CY1NAM02HT033; BCL:0; PCL:0; RULEID:; SRVR:CY1NAM02HT033; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02HT033;
	4:51LiCw7Ofq8DfX/5Moxus7J2LRuYKeE5Ou2X6MGSoLod4yGIUCEJTMU8403095feCheujFVoIho3bWJ1V9wnkNojNxU3Hfg4FyTP7YAaaT3U6xM8IDjhbTpZhSBNhBstCcQTtgaJX01tYwORvngxuSoKTc8MzlJsxUiGrIo477h6sN9bLtb9GtrZ0es6eB/sv9Hqzc0NfyOM/b/hRnJ1HD2lC0tCX8mhGCWaNt8hC+ibv2wVfi2ea7cyuSEuo3FLaTzgzfy5oDXcRNyItUqdPWYcXX7IpV/zpUHsFmFJGET18dVZ0mVEqVccYa8SHqgtqSNbz+I9YUrRPz9qr7bc7Szvac1ozMsoVtUJyPNLpgk5QGh1GHcwxHduiYTTMJ1B0OfNV8Meggl9NBsj2LG5LtivQF7ibHBG9KM5hEjXpWTy5qIzXKCSX30plu+STm8uhYgotN7pY44FzCaf025PZBBZf0+kCgkCUTUaSq9uKJYWeuN0pZdmeKr7JkyO6z6/pfMcuBFfQwB9cB30K6asBIJRNTq8x8s/4zh3BOVqMX0=
X-Forefront-PRVS: 0030839EEE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFOQU0wMkhUMDMzOzIzOmErRUs2WVNTN1hhU2VrNVAzSHp3cVdZQkJs?=
	=?utf-8?B?ZWJDdWlWbnBXczV4dFF3Yk1iYnh5ck9HVFlvaUVHcCtzcVJRL2xiUnBNbEsx?=
	=?utf-8?B?SURrL3FZQzZJdlFOamNrWmp3a0hsR2RFdkZ4d3d5UFFrWE1EY2hnQktVaWNh?=
	=?utf-8?B?M1U2ZUhldDVLS08zR1djdWVZQkxVeUtOQmtaOFNxMHVvc21TQmtyNTB2Nm5l?=
	=?utf-8?B?Qm1penVwa1YyM1VLQXMxMlVOejdXUVJpTGViZDhyaG9YaFVZSmt2ZmZacHVt?=
	=?utf-8?B?VE9HSnd2aWxkQ0NRWE93b1l3Uzd2YUl1ZDB0ODZzRGF5SU8xY1FSbThMN3lz?=
	=?utf-8?B?L1lMbVpCZUxoWkJhME9vWlc5L1lhTkQraGhJalVGQWRwNnptT0l5NGR6Ty83?=
	=?utf-8?B?OFZCOUNOUFhEQXd6ekhVYkNJQm5rNkVwRXc1OTV4bVRoL045RkVRcE12YjZl?=
	=?utf-8?B?bHBUTXFUaGNBTHZTK1Jqcjd1WUxYaE1ia1BPSWNyT1hzWWpqWVpSYnk0cVhL?=
	=?utf-8?B?V1pYWUVXTlo0S09MVHNjcEs0Qk13UWRLdmdTNXBDdXVyeG1ueE5rZEtsamRn?=
	=?utf-8?B?WWxkdzF6VGFWbk5yQ1d5akxadEJzbUxTTkpsUE9ZbnZETktBam81d1p4VGxQ?=
	=?utf-8?B?d1p0a2VORFNacnYrMW15Nno0UW1zYW1kekU2N3pNVzkvVjZFOVcyRG5JcWlD?=
	=?utf-8?B?a2NLejB1UW5XYS81TXVkOTYyS243TTQvemNTRnVxdGN6bDk0QjN6WWs5MWhs?=
	=?utf-8?B?OHBXOW5vN2poQWhTQS85Tks3TzhnT2RabFJ2cVh0YWZjelEzbmZBdFpLYzVl?=
	=?utf-8?B?TDJ6VU1Sa3U1b1lpZHJ3UTRWM3FMNnRlNkpOQm5CZ1JxM3pSZGtVMXRNbUpH?=
	=?utf-8?B?NzJEc3dLcXpvaGEzdUZlTjYvYWRnOUhpMGRQRVB0dGU4TjJDSUdsTm9BcUlK?=
	=?utf-8?B?OHgybEpvbXRLTVBvRWhtOWdmUUJsb09lR2hHclN0bXBMWlh5VG92YjVNQnJT?=
	=?utf-8?B?NGxRN0lkQjRRUVNLcWMvQjZrNTBBRzJzclN4cTAwalptVG8vSVJHb2hmQlZ1?=
	=?utf-8?B?TXZDcnk3ck50U3FrVG45Z1FaN0gyeGhKdEFWeWJFZXZpdFd5SU95UDQydDky?=
	=?utf-8?B?ODNycmVDdWVBRFBmcktLbGswM2t5M05BUk1LUVE2ZTV1eGV3cnhVN1hoMW1n?=
	=?utf-8?B?YW9sUklsOGVKL21Lekg2eTdrQzRTY0hNQkNhZDE5N0NsL0UzWU11UURBZ1dj?=
	=?utf-8?B?c1JjKzdCcTZTWDNsNFNDdThaUElHUlBDZ3RUV0ZNOVhPMXlya3RMUXNDeE02?=
	=?utf-8?B?UWNaUmlqUXg5Z1lvNkg1M3hVSElqYVY5Y05KVi9iRTU1UkpZZDMyNUtKbzhi?=
	=?utf-8?B?TklsSEMwZ0l6Q1FvRTM2UlVyMFArdzE2bnR0aW9mZ25sSnMxNDVyV2ZyTUJH?=
	=?utf-8?B?d3d6bkFVZXJxRjNTQUpoSlkyQnpGZmtPaHJVTURqRW5ta0xXZ29SeHZsV2pO?=
	=?utf-8?B?OXB3aHFiQmt3eUdzSzJoN240Sm5jUStvVVR1Z0JLNEhYYk14dlF0NFVGdGhQ?=
	=?utf-8?B?azdpaVExTXQ4MlBCS3YwdG1GcnJ5RlJaWVlkcVkvNS9OY1BFUk1qbFlOUDNy?=
	=?utf-8?B?RDE0NWRUL0NOMjVQT2tKdXFVYzlUTGFveUEra2hhTEgvWk9EdTdSN2ZTS1FD?=
	=?utf-8?Q?6EnvTc66G9qGp6xC5ZLVuiKuVuwLWNepKCSvm/+?=
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02HT033;
	6:6nT3szLAx3vq6HI0iKbxLd5bWv03hq2sN9VllqC6fcBIcX2IUARHStTGw0FwqT3rgc+gjg5OfUDZsSqzHRuewVcSIdWu6ziaI1DwNPz7p0EAW99UNddi6UjKo5eFCJm1uZkpphKrKNPDEtrFRQQ7eyTO8hxFXRay145Qu1kftRvCmj1C2Fv3jq15VNomT8plEkwEVCLdSf/iCYqQSRLDn8zmf9vx3smauTRSFaJrdTvleTZA7Gn/qcnq5/R6WtdQdDi4ShxBCzcS8iLxVTOGvIZ+jtdZR44H0T2Y4MMCF7crYen2QTtqrgDI3irDLxRYIN4qdVsISgh0NpPlTeVoRA==;
	5:6WqqzBai+skirEJU5ihr9y+pQba+ZnirOjROA6UzGfgwS6DJuWPOi6IMJA9lsoMPsoqErd0SlWazeBvh5UGjsBLgCOz2PmNcLeczAHr5Kv+dUJaROhrPPURiI1H7OmT8CYWVNYIxLfICT5g674806A==;
	24:znCrX8j4+OGQY8eQPUJjR4S06KMOlMxAeBIUP1t5/iucEyuAjKGW7nUC39kc+fIsQZQmquW0bWcINT9g2ucijzuj50mWWUl4V+89oKvnw/M=;
	7:BKntS4yATxDphij7dUEt5D5GTrTVNBctJ+9hOHLBTHVW3uWRnygBeWD2DvKylkcOOQB4bTto+PdjLyRoBa9vVYTrX8p9ZjetFJxp4AzsB7al9niZFboCkACDdKlly+cYNxG0vsLSBtS5/JSygO4u+Ql6/qS7ZDKjloPXavmWVbu3lOV2J+AAKdeF5HJesaPLGWV8KGyUpJE60WKdPFSg4o3Bil2LbFpYxThPQ7mIRZY7rpN/M6Rs/N6oULdpl2FY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2016 19:20:30.9333 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.83]; Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT033
X-Mailman-Approved-At: Wed, 10 Aug 2016 23:09:59 +0000
Subject: Deploy directory outside of tmp-glibc
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
X-List-Received-Date: Wed, 10 Aug 2016 19:34:53 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,


I am new to yocto , I had a query:

How can I deploy the images to another directory..

I tried  using the variable DEPLOY_DIR and DEPLOY_DIR_IMAGE getting the 
errors.

The Error I got is similar to : 
https://www.mail-archive.com/angstrom-distro-users@linuxtogo.org/msg04164.html 


Even though I am using different board, I am getting similar Error


Is there any other way I can deploy images  to another directory.



Thanks
Vĭηҽҽʈђ

