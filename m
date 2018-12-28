Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 28711 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 29 Dec 2018 14:22:25 UTC
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
	by mail.openembedded.org (Postfix) with ESMTP id 07F2B6BC85
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Dec 2018 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Lh1B7eW4gQ8mpSl+83EsOteSYqqcGGoseT9z96LScW4=;
	b=GQTpcpGPcyFb8zi+EDgiJQH3V6FDeyNuuK/BVSKptv1bEAT7LQxYcFnxHgJpUbznSJVZv3GYU3JeQuLV6qBVo0BMZCGTTfJ8KLKBneTI47M2YJ/gSeOYf6RqkGY59WP71CleyTN9qiWhLWM6OiAco+cc51hTfusK6hLevAi+KNA=
Received: from SN4PR0201CA0012.namprd02.prod.outlook.com
	(2603:10b6:803:2b::22) by CY1PR0201MB1899.namprd02.prod.outlook.com
	(2a01:111:e400:527e::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1471.20;
	Fri, 28 Dec 2018 20:48:02 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e45::202) by SN4PR0201CA0012.outlook.office365.com
	(2603:10b6:803:2b::22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via
	Frontend Transport; Fri, 28 Dec 2018 20:48:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.83 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
	CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
	via Frontend Transport; Fri, 28 Dec 2018 20:48:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gcz32-00049s-Hn for bitbake-devel@lists.openembedded.org;
	Fri, 28 Dec 2018 12:48:00 -0800
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gcz2x-0002vY-H4 for bitbake-devel@lists.openembedded.org;
	Fri, 28 Dec 2018 12:47:55 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	wBSKlr9b012811; Fri, 28 Dec 2018 12:47:53 -0800
Received: from [172.19.2.8] (helo=xsjalejandr50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandr@xilinx.com>)
	id 1gcz2v-0002vR-Az; Fri, 28 Dec 2018 12:47:53 -0800
From: Alejandro Enedino Hernandez Samaniego
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Dec 2018 12:47:46 -0800
Message-ID: <1546030066-28660-1-git-send-email-alejandr@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2970300002)(199004)(189003)(36756003)(2906002)(8936002)(5660300001)(2616005)(63266004)(50466002)(106466001)(356004)(36386004)(6666004)(426003)(476003)(336012)(6916009)(316002)(126002)(6346003)(4326008)(186003)(478600001)(7696005)(26005)(8676002)(106002)(77096007)(107886003)(51416003)(16586007)(2351001)(305945005)(9786002)(47776003)(486006)(50226002)(48376002)(81166006)(81156014)(107986001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY1PR0201MB1899;
	H:xsj-pvapsmtpgw01; FPR:; SPF:Pass; LANG:en;
	PTR:unknown-60-83.xilinx.com; A:1; MX:3; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT051;
	1:bk+SrAalIegtIASpsI27jNvCwHjsP/CBogSUVJSn5tHaJzQ9zmSFpHDFo8gRZWvuGVrVhxanfD7L1JsxGK4yREqJYTQhQpuzZ7vBu/NIBxDVJYV5q9X037Hf2Ml55Hyy
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ef4478-3380-4455-abe0-08d66d05c1b4
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
	SRVR:CY1PR0201MB1899; 
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1899;
	3:NpkmpmvWlFYADYKD/MkiMhoDXh/8foHldbzys9qXUrjKHF0gd6Vj5vx/THvXAYBEMa68C7Osue18QQ5dMj7bjLPYRZsAmpQdGc6s7cMbzTtXdfSHgKK8AkWQKpbutasX9mb3dLBZUgaKRmpVVpDd8lo1uIVk07jg4170lwsjGmWexZ/IV1gkzzZUofGAuCUI7tzz7ICqzBJLPX+WkUi4NTuh/4QJ1d6Bw2Xm7+MNj0RH4ifEiG9gl5E1r3rAJ4oDHuKmGJxhTT7IGdNkqt6smLwz3dOefeOTwZ1niZUqybISz9XYaeCShwylc+REJkeIvtFWvIOVrAd1BvilijSfYEo1WvdV82awqRmCFF/EBdA=;
	25:p70odh3W2Qz7lkSRReVXP0qYHomfKD1OjWiBlUUH/50fOO4HZQHINtRQHqXPSP0y5ZkQ11I1qHG9UAs2yTcQ9USocGYhKwpcqMQHaM3fpRBo1Rn3iPvoyavkxt58Y4+xzhZ8AMUKc/hKrW1QwqRXVD01k0uLGgS02mnrwS9bTMTtwa55ZYPwjZtBnZIADZxlkX/VRFb2TQYkXRh5jxoWjzEvmqR4qEmEFEWYCIXPrag4kQr1fhrIDNmh7KKwS5rywSPa+q0ovE2hrH2/lwdMUWQ8k9ziyxgcgQ2u/W0CHd61w9aehO7O81Rg57lBy9M/+AeKZBIukEiVme6fRpnj6QckLtJuG5jnLLScebiX5Xw=
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1899:
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1899;
	31:NOdgFsi54rM7qWvkoG1aZ+m3DQMGCEEf8+hGlXUVy+9h9mio8Xd0TkEANDT2bD6nkGCJRW4WZelOml3nBLftapcTJxBrph7yt9pPycavmaYTDueaVqe1/KBJrI1I1NqnK1I2b2bp+z5E+NONVLUlFTz+RyMI82/C/b4828y+MCv+Ma4FfirQbxnhJ/CWgvBGqfDGq3UqPSkdnvDNuHia5aSHh1mxPgJPvtsn/4yNulo=;
	20:bqnlieuXd9elurnW82pLQOCon0diyW7EhzmgdDUve3SN8KbJgFRTl+42r+DDKhw5wtStAbktW8bFj+EnSyBAoFLehtVuyO0PjN/0JI5QrvG0rbEB3JhfGhoyJvEbD0HDPnhb4q8G97L0hkwjYdt0zS4C0tLDtJs72klSuUTedA6H+TqpJ8HEyIBvHJHPhpXqbAtfHlRwZJnPdOoa8tlhI4EPGQ0DnFGyna/VV3V4bZCpQasjeMhKdbULRI+Euc3Ls+qGz1CII0r5OQVsoQX/Qsz3sDuwfrI/cdEf1AJFO3DlQD02jg4bVWJAtQyVW4fOrOUWUndv19T+Xlok009EmvI0MeKsmTqHKuQF3A7O8KriSD4WOB9b6WrM5qGWNyikUVF9c7UFkq7XVPVz0qiJiFk9IrC/qXx5ihpO6zpOejs79Oc6pZuAmuHaNP9V9x5w5JABSGxGjiz074fTBvdw7FKBqkQ1IriXXIynBsvFbdWLuTnnOejm8JyQupFFUzZT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB18994979AE73879B58B20683ACB70@CY1PR0201MB1899.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220053)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
	SRVR:CY1PR0201MB1899; BCL:0; PCL:0; RULEID:;
	SRVR:CY1PR0201MB1899; 
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1899;
	4:CW8FCmcX5M3PsWZ3ktcDXZxw1TD1pFauSXxG/7UMnnMmblo3dxIqx5EyrEXSthvE9W0bpMsuJkSkhD7MSgWj33/e7uHoDEQu43/3kELR4IolZ+yeMQvqUFLosgWIZLGP04HTwhJ3cmjVLCYEVfDekWK1a4ywyR8CxpLTLsy6k4Rx8ePZp6Z3EkhKtARa4EY6Qx0dJ8SAT8I+/rYKamno8D9mrmJl6qSItTbLCl/lr2SJQIKoWiazoJrQF9TZCGW1l2KH2DrTpEX7VgaTPFeQRQ==
X-Forefront-PRVS: 09007040D4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; CY1PR0201MB1899;
	23:1neYNIQV5zf3o3HRqc2EPYKwmdfSKz1n7xZgYJF?=
	=?us-ascii?Q?jNhjkLSZ0BLq5e5u2tPzLapiTSrsIY0bXrnC5yywyKoD9uL6TVyp/mIsZg+x?=
	=?us-ascii?Q?1Egs99/4Oa1RY2uvtlwuxNdnCWxA8J9vuRnw1SqUJPrSh5Qq+qFeaWxMNAlm?=
	=?us-ascii?Q?e6ABIhGt4F1rtf0/zXBvhoQlY9evAkmuOuQPOM4Xnmr2VrOeVGVSPGWTaXWi?=
	=?us-ascii?Q?EFWvGihhzkfTnGBGBZ93zI86JV4QCITrYF8wMS+YpQtCcFzGInP282tHPpx2?=
	=?us-ascii?Q?GrZCBxw+C4NT7Th60Ga/E3EyZekRJReOLokP1GMbJvuabtzMU8tOUTSoRZKV?=
	=?us-ascii?Q?ubwLbsV3xqC8Eijm51fRCRpnmJ6jocRB91ZyE6n+mhzNzNJ2TryMof1Bkw7h?=
	=?us-ascii?Q?F6pKIDcXPXaoro7qy2GFKIpFiq0s/g2F4WrRDRVzeUZ+lbAk1oeu2u1n7Ii6?=
	=?us-ascii?Q?/tnrFpQnv/k1xNDmHzntjPNLSOugncyjb3OZnZ6V6NJHPNP42q++1cmdp1Cv?=
	=?us-ascii?Q?EJ2vkhyPyeIiNP3R97hiIdlwq+6od9MO19iEHg9YBaoSn2SZL8OYreAF+gdT?=
	=?us-ascii?Q?aRuszvo2dZI2UdlwV9KRITyXdGiXK2vS1phLUjRzJ3URQL5l9/QyKkckaTL3?=
	=?us-ascii?Q?GcRNMZhCGuwy70Yna4bDacNLZHPM98R7moFAB090IrGvGWQWNcV45QgsmKo3?=
	=?us-ascii?Q?SR9yJzzowkkKPBSmmRcqBCGZuyYCLBf/xmf9TUZ3V6SJ1+20cv5EksXGC6ji?=
	=?us-ascii?Q?Lvvh2r6EuHE26vQ2Po+0D393PD8i1n8G12WXbtDksxPjEA5n1DKNY3pBNW4f?=
	=?us-ascii?Q?LXY9C0OpTCSXsIcj8qZdQ+F3pS8GeM1I3q5fVHXjwDSkWYIl4fMKGfRHV3AI?=
	=?us-ascii?Q?jM3chA69vj7N2sCY1qfcFfhJw4v0DJ+f5Le8Z2V2iw5/Vdg3WfgLSQYcZTdC?=
	=?us-ascii?Q?aUg7MuStrsEnR6xJE5f99ZVIk2OgGnMtjPRsMGBT08gBHATQrLA7z/G5JgEk?=
	=?us-ascii?Q?uE78ouwllUphTomqA5bkieJnWdQDlKg98bSLZn1Y+Fzgk5jCIwaq7Qld8g6+?=
	=?us-ascii?Q?gsjm4Et0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: k+gPh0ye5JFHtWLNyRjRugwLUdSnMVWykS5XnA2/70FUaaxAJNQW8rW5mme6buD2+XB0fZZJEg5a9KIXV9sK2puzIxbeTEDTY0VdFQFQOh5FMgbfP7bB/2I4yIujogyARe/BtPvGUqs8/AymJp+b8r7zhgJU9DcaJVy/kqczcuOG1pA+W4TJnQlBeSi9MdILvHyCwNRjg/jq8Vtiw3/Jo/lEjhI18EFvO1PUujU1gX7thKYhXYmk0wieoT/1o/49f3+Rm6hRXD6cpSAcX3uRhTm11zxqqeuLCxz0+QZR/h8oY9L0Or3ijG3u2iXbuhfE
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1899;
	6:Eh5ESU47e90Hbcp8Ah0xYfGHvzNC1px63axnNpctc7d5G/9aDiXRepPfttbOPSGAe5DEqUkpO/BQdfXreN7jKlzdhbScRMBlEnOJesu4GWP85rjJWw5VLh4U+gr8EsqC2m/Uh0bzgUNeUVcCPZdobKW3Mataf25AKwshQyGVI/ZDmuI6g5SOSdY04GT1cfNZiJ7RBuClpfp0U2bWM0+7RKbbx6jOn7AuUkv/McyONrK4ntgAvWzOhqRBKHKMBjsJIwUj9/2atyIL9n7MLeiefkSGzD1WBX4c6HKHYUAby22GuWECrpNvI9EPzaFnPRFIYFEPowzInKyQrz6vqFiN/1pKIJLIP62wSyd3QYlMHoK8bzVkdpuBKiruCDPqZ7wOnd3yyDStYC53l+WLbCMuboFYW+448Ps5dCQlS1hMYX+vt9OSj93ZdTtTqy5v/ShEbMeJX7TO53jA+o8KzkdvBg==;
	5:ZohywMHpXq+AxYJ3UvYy2L1CV1leiGsz/RwBLlihdCLU8pRfaMPokv6aoT+MeEceUHs1HpfiIEYYbrLbbUzWSyZYUxRbVPj7MS5PoGVJ+T9nqFVUWqMb5pMKgxIOyDKBcOlEopuoF7g8ZDm0uVoWR05MOqoEdwnZabRvHKdBmmg=;
	7:bdHkvMY6eKQlXtIgmRytjIRw6bce+0dSeyHd+nNCNxARxmsz2HEy5aNGDMa1eraFfLgzxOAhEDy39t2A5avFnHWzP2aWurkH3Y+knCDG3z3D5E4bU3WWePfayDXNR7wHOZFG7dZ4MP9y+h7oPofC1w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2018 20:48:00.9892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ef4478-3380-4455-abe0-08d66d05c1b4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.83]; Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1899
Subject: [PATCH] cooker: fix indirect multiconfig dependencies
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
X-List-Received-Date: Sat, 29 Dec 2018 14:22:26 -0000
Content-Type: text/plain

When an indirect multiconfig dependency exists, such as:

A depends on B, B has a multiconfig dependency to C,and our build
target is A, the multiconfig dependency to C is not processed on
time, hence no providers are added for it, causing an exception in
the runqueue because the dependency does exist in it.

Call add_unresolved() for all available multiconfigs before processing
providers for multiconfig dependencies, detecting mcdepends on time so
providers for them can be added correctly.

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandr@xilinx.com>
---
 lib/bb/cooker.py | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1897936..db52964 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -639,27 +639,38 @@ class BBCooker:
             runlist.append([mc, k, ktask, fn])
             bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
 
-        mcdeps = taskdata[mc].get_mcdepends()
+
         # No need to do check providers if there are no mcdeps or not an mc build
-        if mcdeps and mc:
-            # Make sure we can provide the multiconfig dependency
-            seen = set()
-            new = True
-            while new:
-                new = False
-                for mc in self.multiconfigs:
-                    for k in mcdeps:
-                        if k in seen:
-                            continue
-                        l = k.split(':')
-                        depmc = l[2]
-                        if depmc not in self.multiconfigs:
-                            bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
-                        else:
-                            logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
-                            taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
-                            seen.add(k)
-                            new = True
+        if mc:
+            # Add unresolved first, so we can get multiconfig indirect dependencies on time
+            for mcavailable in self.multiconfigs:
+                # The first element is empty
+                if mcavailable:
+                    taskdata[mcavailable].add_unresolved(localdata[mcavailable], self.recipecaches[mcavailable])
+
+
+            mcdeps = taskdata[mc].get_mcdepends()
+
+            if mcdeps:
+                # Make sure we can provide the multiconfig dependency
+                seen = set()
+                new = True
+                while new:
+                    new = False
+                    for mc in self.multiconfigs:
+                        for k in mcdeps:
+                            if k in seen:
+                                continue
+                            l = k.split(':')
+                            depmc = l[2]
+                            if depmc not in self.multiconfigs:
+                                bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
+                            else:
+                                logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
+                                taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
+                                seen.add(k)
+                                new = True
+
         for mc in self.multiconfigs:
             taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
 
-- 
2.7.4


