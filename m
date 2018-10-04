Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-cys01nam02on0057.outbound.protection.outlook.com
	[104.47.37.57])
	by mail.openembedded.org (Postfix) with ESMTP id 0275C71BF0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wp4kmFNhD3UmQBT4+E/gg/3XVqt1njGdDBOhpYZT7so=;
	b=CojFAcXq8UBFPOvuBjlZR3oyE6R4o+Ac03u9Yr0V0xf9BUHtUEnkk/5KURFMsiRo84QZig8ZEKlL4tQt5BgILdeQS8LlAHgsoB1RjOBmsD5FoCpDb8ORxHDaaspMf5cEv6qJEyt2WwgfSk7pf1zjyjDS30sDRRfSDy7VXI8n0Uc=
Received: from SN1PR12CA0059.namprd12.prod.outlook.com (2603:10b6:802:20::30)
	by BY2PR12MB0145.namprd12.prod.outlook.com (2a01:111:e400:585a::18)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25;
	Thu, 4 Oct 2018 02:49:03 +0000
Received: from DM3NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::200) by SN1PR12CA0059.outlook.office365.com
	(2603:10b6:802:20::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via
	Frontend Transport; Thu, 4 Oct 2018 02:49:03 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.38)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.38 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.38; helo=COS-US-IRON05.COS.AGILENT.COM;
Received: from COS-US-IRON05.COS.AGILENT.COM (192.25.218.38) by
	DM3NAM05FT045.mail.protection.outlook.com (10.152.98.159) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
	15.20.1207.13 via Frontend Transport; Thu, 4 Oct 2018 02:49:02 +0000
Received: from cnd6270d8d.cos.agilent.com (HELO localhost.localdomain)
	([10.46.25.63])
	by COS-US-IRON05.COS.AGILENT.COM with ESMTP; 03 Oct 2018 20:49:01 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Oct 2018 22:48:20 -0400
Message-ID: <1538621300-112900-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: =?us-ascii?Q?CIP:192.25.218.38; IPV:CAL; SCL:-1;
	CTRY:US; EFV:NLI; SFV:NSPM; SF?=
	=?us-ascii?Q?S:(10009020)(39860400002)(346002)(396003)(376002)(136003)(29?=
	=?us-ascii?Q?80300002)(438002)(199004)(189003)(29502001)(47776003)(426003?=
	=?us-ascii?Q?)(1857600001)(106466001)(6916009)(476003)(16586007)(56603000?=
	=?us-ascii?Q?01)(336012)(51416003)(126002)(486006)(50226002)(2616005)(666?=
	=?us-ascii?Q?6003)(48376002)(63266004)(7696005)(2351001)(50466002)(268260?=
	=?us-ascii?Q?03)(7636002)(77096007)(26005)(186003)(478600001)(2906002)(10?=
	=?us-ascii?Q?4016004)(316002)(4326008)(305945005)(246002)(356003)(8636200?=
	=?us-ascii?Q?1)(8676002)(44832011)(106002)(8936002)(36756003)(107886003)(?=
	=?us-ascii?Q?5001870100001); DIR:OUT; SFP:1101; SCL:1;
	SRVR:BY2PR12MB0145; H:C?=
	=?us-ascii?Q?OS-US-IRON05.COS.AGILENT.COM; FPR:; SPF:Pass; LANG:en;
	PTR:relay?=
	=?us-ascii?Q?.am.smtp.agilent.com, eu.scan.smtp.agilent.com,
	cos.smtp.agile?=
	=?us-ascii?Q?nt.com, relay.sgp.smtp.agilent.com,
	bastion.germany.smtp.agile?=
	=?us-ascii?Q?nt.com, britain.smtp.agilent.com,
	relay.germany.smtp.agilent.c?=
	=?us-ascii?Q?om, bastion.am.smtp.agilent.com, scan.ap.smtp.agilent.com,
	bast?=
	=?us-ascii?Q?ion.ap.smtp.agilent.com, relay.eu.smtp.agilent.com,
	bastion.br?=
	=?us-ascii?Q?itain.smtp.agilent.com, nospam.smtp.agilent.com,
	bastion.eu.sm?=
	=?us-ascii?Q?tp.agilent.com,bastion.and.smtp.agilent.com;A:1;MX:1;?=
X-Microsoft-Exchange-Diagnostics: 1; DM3NAM05FT045;
	1:k3/r/IDBKkN0YSv8RCmlhLOJ4CwPVo08tHtVww84/AK7GzsK5Rkm/7DxcEno2eKOg3DxrqvPkGiKmI1uKlwN3sSMoi1Z+B7rfxG2ypaec9GS/bENln0Krj3YxmtL8etT
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f2ff61-79e9-446b-a0b7-08d629a3f195
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);
	SRVR:BY2PR12MB0145; 
X-Microsoft-Exchange-Diagnostics: 1; BY2PR12MB0145;
	3:Ol6ISJoFnY+kCb2v65bKihPEfy2u8fFAgTqQGZOHuAApfdGDeSiYMUM605UP/lDjJfBDBEcMWJlPEVgZGdhwf5uIP3lwRaoYdu1EFhw1QDX2o7OWfutiEg+Znno7/pFKZv1yZMuupJRfy3N/8J0tDnSiOr4+Ip/DxNcppU86fHW0/WrFVd1bFR5MWAWc8M4q2csWD3feYx/l4yn5vkhKE15QWWLY1ujitasDls6lf5do/yAdRCBKS5TspP46SO31EZjlbYyjHWni8/HI/Edsvegy5D+wkVDtN+q2nK//JnsAOLkFBqdZU2MjzvIhJuYTVYU541Lq98Mm9U+m5zLVgbTTIrNxk14v7ioJMUq06Ro=;
	25:e9NXyVmnbT7gly1s2/1Jk9m9mFFi1B2cx6Nxpmzz5oa+WnInX/3IKpodyd1jnlVrDfIFVHBNJIgcvWKXGlY7lHtubOF00RLR+U4j0aT2t09gd9GGvChJHA4P9F4bNiJdrpQKeM3+8AKLajKjGrMmXOsbkdu/jgMoBbowrb+P7Bd8Pd/392QAyK8ANqP/5yEerAILL6kDHC1yqF96nHRUabux3IwLF44fTcoc5qmnJaRztbJMlWbOVEWUjvNZukbRn0zj67NiOlIXZeF2vWADvhDdHG8KLjgTx5r24qYGqli2lu64xBJ5VF2MuJHXOpFBrECKCxFYe5PM0trutEA4fQ==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0145:
X-Microsoft-Exchange-Diagnostics: 1; BY2PR12MB0145;
	31:numWECXMjwxvw+SLUgsgP61R1UU1sO7FKNXg2Cye4TxRMCW4QJTON6K2RFCnrKnPBuFJDSLLYYJJn/SaeQZ2tyMTaKBpO82huS0BUchLwmVjZfDH5DQ0EvK4d19gucHvPa1W5Q5He8ZX8Aoxd5bE44oYuP3OcPAWy3R2CZ87WbVPGt8wmf3BqjJTOizdU6VpFDAYG5jm3s7xTjVgXFB5eI1MO1tVwNnu+0gvvNdUtLY=;
	20:X5SnOLYPgP/yRCE9NIGT7rgpjOe3XWgkd/dPMMUD32l1yXcY9NB/5m9sky7src9guVergnZB64F24FYpQAuhhNPSLtP54wvOD7JOJI5YAgPgr0mkt38iqg5bhklBAu+EdVjJpr+udwNTjEqzMpJ+xKWn7W5yQXy3TqbjRc8lqQiqKf7/kYvXRLbFznADTPmfM6jMEOjYaWjVf64o5Retd27PQLz7NklYJpxBPPndnrnyX2TY3MqLsagGrkdjQ/PK6fQybz54kq4qxO6vgJIGy03OP4SyNzXQx3goO5Rvj5H2FTiDFgUrildC0jaLPunnGhqUefOlDyVlv50XU7rB+DG+K4WSTGx0yjcPEiAN6uUQ5mPibyEc8ZaMXfgkYwTtDkuWvbxY6FSP6fzX8ilcGg09V0utgFTdbKuA5OuUwYdNHpEp6UMAqSgKKbXCTgB8WOJUAFAHgDQYZRdGaMimQXOaVPXFGS0y+Wpm/Lbm6jyP1zlqzohprVwXGULeFa6sE8/uOtAcDHYU0Zxf1C2kPigkJg1uKKsAO/LMDAoLVhIJI8RjeYz07GfMLICu+JIN2OltTxZBobO6oeuNqN+ymDg+1bbYv/BcKo8HG5TFGcQ=
X-Microsoft-Antispam-PRVS: <BY2PR12MB01455FA69C1DAD960FB92E958BEA0@BY2PR12MB0145.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181592364885221);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);
	SRVR:BY2PR12MB0145; BCL:0; PCL:0; RULEID:; SRVR:BY2PR12MB0145; 
X-Microsoft-Exchange-Diagnostics: 1; BY2PR12MB0145;
	4:O+dyXztUrwr7edzlFCwmx9jBDCdddSl0fRKA3yXtd5MqhDM2wvfA1xXerScbHP5ZipfqsqsmvDmYr1w24mZRVDUttMbeEJ2GhfzuOkO84SvFoMWJ1rNuaaC8gA2K4owirUWjRGMIykk37nAwrrYpzaX6xcmBQS1Mb248sNa5xyGHWy77zHnyRnD7YC5vhOKSM7/GWUKob6UOeAyDIl173a09SNx+lqiJdz25vEKH7k9O8ptqL85MxSiiTIbY2jLNZn5rHIKqABa9AgZCo4Yjm/UJGBj50KQgwyP1bCfid9Y+YNg7WUdeFELkJUKMcphL
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BY2PR12MB0145;
	23:rJ04ReBKwhG8pVGTyYUZmvPs8LMVXh+VzRVpOb5Jx?=
	=?us-ascii?Q?laLZjyLL8P/IPUbet0D2sUAsQ3Z8jDLWkLadtBJMqqqgSFpfM0FPezL5+Zla?=
	=?us-ascii?Q?o5d2bCxo6iI/VraymXouQMO4jEqaHsXlcSfEx4R7UWU12gP14mRnMVNx27Q8?=
	=?us-ascii?Q?8/BY70BfHnEnM8eKsrFY7+4EcU1lJ8FIzIUI8VXE4ak/sVC6Xj8fLsIgdep9?=
	=?us-ascii?Q?//QvEuPualqEtFHgpwC8mdNsz9tUvtMdZXFbsIL3lmRhVmgkiKLbkr3ucmQU?=
	=?us-ascii?Q?zM9ltaDtQzkKUQ9q/d1YGgBw5nI+5gnSjHMjdi5IkROtYeNAWtBF9VAr3fed?=
	=?us-ascii?Q?tRXyGJlnK+HYIc9KwLzbsGf3/X7X06t4YcgaaLVGDdP9ByFL65PF0S7+AYA7?=
	=?us-ascii?Q?JazzRaxaDp5uv7q8MXYTpQzev/9/tvWM6ntxhQUmaoB2IPgxBJJxnlpTcyXA?=
	=?us-ascii?Q?6+J2gIFLGNtG/EugsDfdPM4c5RTfAVk55egXvwowK4u6h2K1dz7FL0OIAXnt?=
	=?us-ascii?Q?JMhMuvXOjJJdWOjqHZU+S793T8oSX7pzbkfAsDmtD56/ZJarlPpRV6QB2lEF?=
	=?us-ascii?Q?l6ISO/czhubo2PmlaSV4ulpfyB4mirhfXl7IdnQQwRBmiOmtzn8fTpJOiOgj?=
	=?us-ascii?Q?4qPKiEf3gFRYnvtNnu4s3DKPpBOByRm5L9JcRKFqIHP+DXqiO/v0QmAke/7u?=
	=?us-ascii?Q?qDZToCDTdNg7lrxzHXGmukjsAOXiT7FwWRnkd7LkNjCss28sIfISUgrye3zw?=
	=?us-ascii?Q?mI5HMSY+mHNsedY/WrhuGbNAxph4joNABMUvbCT8lZoCbfgZKpgv5PPYNqT9?=
	=?us-ascii?Q?uWXS/yAvMfj1+U952tBpyE5I3FFbTAhCKg+F//N8QLb7isd7XrrzCGwcpeBS?=
	=?us-ascii?Q?hPqALab5xud9/eV5Y0VxKdjLEp+2EC0r4M+10Do2gZVSOy0wLDt4uVtK8i61?=
	=?us-ascii?Q?WxONZ0Cv/+dXZ5hgXyek98YF7/sKJo7ObxNGliZtAcdF787aYeCR/fAfOchQ?=
	=?us-ascii?Q?MY1DS6M8uftlIkS+YUvc9H/BwAoGTBJ2R2+8PvuJBsdD+PjNqizdSQkttfLq?=
	=?us-ascii?Q?HvTm6tomKV5NxdAnYFShifrg0sLfxobReGAGp9xXIV6b+zAsNAtwxw5DlP1d?=
	=?us-ascii?Q?JEzscd7Ul3D6Sp/OWm3j/VRGKju+RmE?=
X-Microsoft-Antispam-Message-Info: kUHttld6gCIikvcT381NnhTTG6djma0NbcyUMd8I3xqX00vv5LdWNuAfbwqog3ay8TNDle98gk8ibUxEMDjLQdvMbVleYTpuVUffRzZ5a95tl2Pgv78f/jkn0IYUjtquC9BKf9FWZkwmbH57H/T1czrlOGa3Cc1tNOSnLZwYnRg1Woc0LqLNekpehDZK2qxn2gZn6Amvu9b1kJKmc2ivGXW7VImjWyuPzH4NOyrtIDjsjvsW8nclZgxBFRhqvU/HaimMFqe41c/JrPmScD5g7+tzCARatsHVYjprlMBLUc/KJNqnS+b6oxHMZICJecAxJtEk72IXkKOIVeFQ8BDKRKg3ywLa6r3XMnfArZRhIzWLzVnpuUFLjJeKVZsLw/UlYJHl2FtQw1hYNvBvhd4owg==
X-Microsoft-Exchange-Diagnostics: 1; BY2PR12MB0145;
	6:WDzXqg9Vxr9DSPGnREiT3zp76a2joTQa2iCGTaHpZ+pwOI6/70s9m4mApbSCemcXAf5JBKSrlqIPEo23qM9ClvL2Q71Na5LFxwXcrGKioZNweAC/wC2zWzjLo72F1eLPgB8yOWzLGPp7oBA2/9oPuRvkvvgg43ug1opS0k12ZLmpNvYN5yUQRo/49AyQhjiJvKGn2S0EOq42fayTi2xgGWbXA02sXymuHncxSttXPLYgP5Z2TyIUC53NS/oMYhCn7yGRvLDAuszQjAMTBJRlq6h1mn3RHPAiqlHMgLAN6y/oagrWh6RhoIU7xyEnqY45xTqb1VYHnnn8OJ+g2KgA6sikWupPdyl4ypCPhGTB0sIZIYWFBRr8Cbyb7kXeAl1gaZp5oSgjtj6LSce7nbkITDWlpGNZ1HeKjYTraT/aXfWBtexRK46ikRd4J/ppt6LdQ0XjAS4PHsnwdzmY2vdA9w==;
	5:vEgzJTRgZa6uPChLSDJc0J3HZHU2J4zxy6ZNlVZPLXNPjD+HxEBls8azioEJUbUywdEr7XdUa2z6k2rYIQfE+zFEN27hqY4BnIH96CksONZybaFGK0725O93c/qRCNIq0QbjgWB23yPGELJiaV9uiMRkBSdN+nYHPRPE5JZ1WQE=;
	7:4dFX0h2D8rG0WrRtTveNpchMBVFHprJQmuBz365giMf+N9ycNSsnfhi8nFYlRNonxlJxn9Www7sTYOu1/zsHBvZ+pSPM+y7ijxkXU5K00Xs5SPVHKmvIK43Rnch5Eyarse1ExB0uBjq7BicOmveEHYsR2Zc349gJaT+gI7mpEKIJjQZdQVAxyOV0oS1DGGq8k22DJzT8Uv9mzmoq6gSjadblB2EQdtYuK0BsGFTWKQu9YWMBbNAr6GpJSc1b8UC0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 02:49:02.7620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f2ff61-79e9-446b-a0b7-08d629a3f195
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.38]; Helo=[COS-US-IRON05.COS.AGILENT.COM]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0145
Subject: [PATCH] build.py: support custom task [progress] handlers
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
X-List-Received-Date: Thu, 04 Oct 2018 15:21:35 -0000
Content-Type: text/plain

To use this mechanism, you need to inject your progress handler (i.e.
something derived from bb.progress.ProgressHandler) into __builtins__.
Here's one way to do it (from recipe-space):

    def install_my_progress_handler():
        from bb.progress import ProgressHandler

        class MyProgressHandler(ProgressHandler):
            pass

        if "MyProgressHandler" not in __builtins__:
            __builtins__["MyProgressHandler"] = MyProgressHandler

        return "OK"

    _INSTALL_MY_PROGRESS_HANDLERS := "${@install_my_progress_handler()}"

To install on a task:
    do_task[progress] = "custom:MyProgressHandler"

To install on a task and pass extra arguments:
    do_task[progress] = "custom:MyProgressHandler:my-arg"

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3e2a94e..2e14572 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -387,6 +387,14 @@ exit $ret
         elif progress.startswith('outof:'):
             # Use specified regex
             logfile = bb.progress.OutOfProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+        elif progress.startswith("custom:"):
+            # Use a custom progress handler
+            parts = progress.split(":", 2)
+            _, cls, otherargs = parts[0], parts[1], (parts[2] or None) if parts[2:] else None
+            if cls and cls in __builtins__:
+                logfile = __builtins__[cls](d, outfile=logfile, otherargs=otherargs)
+            else:
+                bb.warn('%s: unknown custom progress handler in task progress varflag value "%s", ignoring' % (func, cls))
         else:
             bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
 
-- 
2.7.4


