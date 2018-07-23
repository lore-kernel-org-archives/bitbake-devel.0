Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0064.outbound.protection.outlook.com [104.47.2.64])
	by mail.openembedded.org (Postfix) with ESMTP id 0A5EC60116
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=I56xEGMDGT7xZCdOLg4y+Hur25fmVDW1Eb9usuhZGNc=;
	b=SIR5eapmLG+eeM/SpQoaJ5x5+5sk96O4iHgB5fAl326gR1csCNDeLP0Qvo0+g6Pv9uHL3xSGzQWVDTguILkUypS5nsk/b/YfoiqQJPwOzB8Fa79yoyBi7l5T1yCe60k90lrNiQd7Odwy9cgi1q+O7HzxkqyriihVN1AmUn3deWE=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:43 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:56 +0200
Message-Id: <20180723154259.9076-7-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af506283-d0cb-40de-a2d8-08d5f0b3120d
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:d1y6PVbLQeEaLg98OKxJd+GqrtuU3lVB0Cf/2rYqV6NtNQt++42+oOT7bF2f0ycIyAWfK7mCPCcKsJ1/VquFBFwXoER47KEL4RG66MXtfpptPr/EL4mHA5cqiUrzmYe3ENRmg/oU1pq3PEF7ppelpkPBzW9vaBRNADjVILY9rGer5XqPnR52RFN3ErLpvtq6q/jv1CITTGhuHQYVJ8nkA3xNTnvxQs9NA9lcIr0tzG+UVWAsWgScYaCT9z5uFT81;
	25:yILX9ekww1d06wKnThe0A0Flz+iPMTyOz81YTJi3WCO67VUgBzqLI1a1p62RBAsS2g6CwhbWFyk0LXEI4N1GIkLna1NJeFz88dI4yOJQUw0jRYvxwRsRQjdJY19l1hkO2ApbNon3+JyypbNCQn+G/PrU38uY2+7O+sKpE+ETdXK1sYt4l17zSN0H3Ew9otpBKDbPAFMjdaT8jF3HAjpcPwF70QZG9qpuKE2deKVJP3n+sybh+7qyP2NicbyFxCw1LmPa0h9olSK0gpo4/6DjlZWXy21H8vURu0Bjb6xyVHMWQNj+7ioJKL6IjQuyg83dyLdoKGS033iMnaMnCdM0sw==;
	31:452CejYAMVAYQbiWWUDQkiODXUSH6PH1tMrb46q4xkAw4rZACpHxby+nUCle+4cUYv/klvDK/5D5NdKiR/UdKm/HQBcEjXePQYxuitDsvLP9QMJya1VVUdY92pKBJH/MYWM9rPLH0c1OakHz7TYdTDHmI0evyw4JTqF+zHu12iej0kJgRydjv5hXiaqle1+IEbx6JvtC4U18SUGD/2R0xB2oNfmhw6sIBjQIlCzfSDw=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB38270F6B87B5D7F26575DC5C8F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:asdchntIYldb75AYaJEqh8eaQU8oNwQi7I4srkAfZQuDRK1s/AGtcsT8BtveK9RMUBvcuFTJ16igcEACPD/WtAo77jSfjd2ynW6ThpmHbee41+UkDcJ8mp2bmNJvMFbCtvxXV7OXD6+c0ET+zA6GU/6+7LX0yN1L9pPvUwDeWbGzNmhWFkWcov9gM991jl9ATsIj9GUsmusP3Y8qmU6StP6kA82sljJLUcdWk2g45K/UDMPQtTYfvSW2CMJTTDFqJDMLhpJGRRAXlx4SiHYaNZ0jyaDUcpNqtWlL1IMyNMEZfa8wRWpOik735hO5kCucHvExXwhPpuNOn8W9w0kuTLuEVXRnv6hx5hj49b5ve9wtchQ7f7IF8AEpAzQPaF5x
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(81166006)(16526019)(186003)(11346002)(446003)(14444005)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOlZzQ1NRWnlpdlk0SExUcTluN0xlQlNnV2E4?=
	=?utf-8?B?OVpVc012a0Q0YXpxbjV0Q3hwbHYzSFFQRmtaTnBRcEprMkdHUnppN2Zkc2h6?=
	=?utf-8?B?VnRCcytkL2JjL1hzV1JxbVJWYnBjUnd4cVFERTRNaG1FWUtZZFVjOGd0dExQ?=
	=?utf-8?B?a3JuSVJMVmxDQ3ZUaGJVZGV2eFg5eHB1V1JoRUNSLzhjV00zdGxyd2IvN3Jm?=
	=?utf-8?B?WXVDZkZjbnI2TWhKeGRweEE0eGJEOERidms2N3A1elRmeE1pTjJ5NkVNYUdZ?=
	=?utf-8?B?ZTBPeENKUmtBNUo2bExTTUVFKzZzNGJIYVpUN0FiT29XU3pRUy9wdmFGMi9y?=
	=?utf-8?B?OXJLUGU0ZGpLdHZRQktNa05pbEd6b0hnQ1NJMTJ3MnNYMmJiQndORmdka0RF?=
	=?utf-8?B?WVpUL2V4NVVBdTc0ekQrR0RkNHcwU0Q2L1kvTEhZbHFFbkhxc1R6cUptay8w?=
	=?utf-8?B?TTY5VGFEeHlialp4VHVhNmtZTG5pbEJzZWlkWXExUU91K2krZStjTnhTTHNW?=
	=?utf-8?B?QkoxcE5BZU0xTDQxR3VlNnhpOWc3VjJzK1FJVVBnLzNwb1JXckZNSmhZelRq?=
	=?utf-8?B?QUs2NG9oNkV1cVl2dHIxUXZDSUxBVWszWHA3WWFaTVdXUFI0bmYvUGxZWnZz?=
	=?utf-8?B?eG4vejdVcHNNMmRPVmRKZnQ5TkNyU0hwQ0xCSkc4WHJxY3FhTEpyUU5QVmVI?=
	=?utf-8?B?SEtlSlZpblJCallLTnFpdVdFUFhKREFMNytzMUhiUDVlYm5CQ1FjZXpGV2w3?=
	=?utf-8?B?ZmVnSWZ2OGxiR3pWaVYxOHdCQm5ZQWtINmNGdXA4TzR5R0x2MTNnaVJXVHJa?=
	=?utf-8?B?M2E0dzFvOXMrOXNuSjJTOGNFRlQ1M2Q1bFg3anliTnVDT3ZuZVZoUnNlSGlS?=
	=?utf-8?B?TzJDVCtBK21tOFFYKzU0RXVIMmxaQ3lOZnZtSEgwaG1XaUExak03RUJDeFRV?=
	=?utf-8?B?SlBXbmlPWGZ6UWJuSEZaVHZFZnZScFBXRzdpRXpvQ1hxSlRsVGhPdlFFR0pH?=
	=?utf-8?B?Rjlxa0VBa3VxM3MrN2JEaEdFYUlTb1JDS1I3cGIvN3VqbFVQWkRxRXZWNDkw?=
	=?utf-8?B?cFBzdmt5a3Mwc1VUZWt1VDdvOHl6TU5jbnhDdElKWEtROVA5dGxkSkE1Qnls?=
	=?utf-8?B?T0FvR2krT2EyN1JvU1J6M2hGdElSWWdndldJeW1qckkrd0JaTCt6QTVuY2Q4?=
	=?utf-8?B?U01TcWlkL0RZcWZmaW5yZFlBOTAzaE9RU1RXRk5KUDkrNXVQdjdVc1JzdEpx?=
	=?utf-8?B?R0ZtTlprVkNjSnRnSEc0K3paY0pzWnJrRmpPMDlzSFRpeFRDMHhFNE1aRURO?=
	=?utf-8?B?ZmhVZktveFVuNE1TM3BwU0JVVTE3M1UvSllYa3ZXYjFrZ1N5YUlNUFFPTkd1?=
	=?utf-8?B?a2d0ajRQUnRPQXpEMXFJa0pZVWtuRlBCNURIZktYdVd5bU9QSTdoME9NR1hJ?=
	=?utf-8?B?bzM4dEx0UW1YbHlWTm1mODRQRmxVZVBNZXhjbGNMOFJubnNHMnBja0VIMngv?=
	=?utf-8?B?MXFRUllQRHM3YS9CR3o1NWJWWVdqNHlqcloxWktObG9hOUxTalg2ZzIvRjFU?=
	=?utf-8?B?MjU1UlVVRVowT2t1M1Y2aFdiNkFnYTVXNjF4cjZlc3U2NXE4Mk5RUDNhbmVO?=
	=?utf-8?B?WlNyTXpiY20wMTAxYXQ2RkpCeWdZMFJzQ24rWm5pT3BsTHFwWEhWSFlHUWti?=
	=?utf-8?B?ZjdCUG1ONElraGZQZytmVnBmK1AwSitMcGhRclRQMi8rZHpidUNHWXRaaHFk?=
	=?utf-8?B?cTgxNzJPY2tzTStpajF6QT09?=
X-Microsoft-Antispam-Message-Info: 8cU9GFwF5V4E1Ltj7tIKMDXEXrxjd7YDoB0NQNLWuGZQtryz8EjOPAaOEgqVtqBZt5BvmWTH4tgAZ1hPzDIySgIbUKwZufLpWkYsY8xE8k2Hcd/ErAc7f9Cr10u7mdiIcAhBpY0qWPLKuhI+uTnE0RTOkzwz1Bwup6rj0jvjIzAzdRcZxJJFvfxKFXEF1+/rXWKU+btkc6ysWu4MoZHJJUoqZS64nuJcyC32mjYBp/v58J5q3d6jukDjCnYZa7dqXfZLTC81rsCfVayhTPwRognDbCG/NyIFLilG3x50qysOeiF1/j97sqUqiX2dU3l+WwU1jg6FmNRHIfi1wBa3p07HSAtZxPX0BNzDllkCItY=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:lgatOjhf9PtOHDhJLlBC4OW+lRj+ZwZCvxIEQs0Kdac0Ru2TXuCxdy4r5uRcvPUnECd57VhiI+Pu/7pg7ZQjK9P1kwPqjoaf6A/lsfpQs5f/V/Q/C+JkloDp/o9uGrM0MMZBDpinzGqcCad82Mjc7nRHeRk5lfDaWITqfsHQuyxuhcah2s8DbBdbp05xxObNDGIRFsxqhv+OA9CB0TC5j8yJGhmeEsf290TOzv17PXRBj0k8VnfCorm2wvpse18CIRbsX30To+WUdlz40fYkwe+rBr2rU3d4CHEv0db+Kv2+QUZSwdaIERcgCMqxTfsC3w732+XDNdU3UwhLCFPsla+TN72uK2FwUTLrHfn8IPGwBJX7A/DfNMzJSKrzCPrWYLaNulzwSl7JZv4kEshQTOju7Isb+U3vzzNY7mWY0vkaKnnLChfQZpxgCDOzaOcrNkCLs2Zj9WFXfXqfmLgJMA==;
	5:EUX6NHIsbvRM+xZHDF3UW121qWv2K72kPjHhH3TYaiVtvxujpCp3ci0VwoNXMF+dcrRXVYBDi6JjpN5ArDvQozQra0sVNMztXbXD2mc8OPOyIJX+MpVVxZDsXTdQXiR/GuO7E+KKXRqmWdekg4r25kPIjjYbwzk93yxaQiZg6mo=;
	7:9LQtvrxby7a6/MtdrRcZa2sDjT7skCeymjymxcdO8fPbrHE39YGRuJpskcwohdaZI2owG2uYiC5z6qEtLzTSqE9teRce63zckiCIpUf0nHIIp/7HsOO7OChtrSM0L+JY4hgENQRV5jGAIT/74WlwqWDtlTZUEVUT2CbvpEl4Cbo8O3qRzQ9Jx4KrJPGPtyG6WvkjSMBB71CHslttOx/HJyWeHa7nWdyp7EpsCa5aD08UvKu4k1PgMKzA/2HWInzG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:43.3301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af506283-d0cb-40de-a2d8-08d5f0b3120d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 6/9] fetch2: declare urldata_init in base class
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
X-List-Received-Date: Mon, 23 Jul 2018 20:15:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Declare urldata_init in FetchMethod since it is implemented by every
fetcher anyway. Always call urldata_init in FetchData init.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/__init__.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a83526a5..c8653d62 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1259,8 +1259,7 @@ class FetchData(object):
             logger.warning('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN'))
             self.parm["protocol"] = self.parm.get("proto", None)
 
-        if hasattr(self.method, "urldata_init"):
-            self.method.urldata_init(self, d)
+        self.method.urldata_init(self, d)
 
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
@@ -1349,6 +1348,12 @@ class FetchMethod(object):
 
         return True
 
+    def urldata_init(self, ud, d):
+        """
+        init method specific variable within url data
+        """
+        pass
+
     def recommends_checksum(self, urldata):
         """
         Is the backend on where checksumming is recommended (should warnings
-- 
2.18.0


