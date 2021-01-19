Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
 by mx.groups.io with SMTP id smtpd.web10.17737.1611089986084310678
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jan 2021 12:59:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@garmin.com header.s=pps1 header.b=KOd9oben;
 spf=permerror, err=parse error for token &{10 18 _spf4.garmin.com}: limit exceeded (domain: garmin.com, ip: 205.220.177.212, mailfrom: matt.hoosier@garmin.com)
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JKwaCE008861
	for <bitbake-devel@lists.openembedded.org>; Tue, 19 Jan 2021 14:59:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pps1; bh=DlkW4nbJhXarKQNRP7Mx0uYbVWh2LApkR6x0DI88Ykg=;
 b=KOd9obenmMa0V7l0TCDxDx1rDkt/9uzLwlw1Xndg0rve/KoX0h9MciLQocbh93b2OlJp
 ZEXpQEf2syBm4lp6PpVBwVcLJyIVYDwUKON4oUr5nVvrT6HKsd7tGJa3G4ifizaV8BGD
 D62Wcr2IKPQtesTDvEIomK87ZzAvzjVco3so9TKzY8VxaklzNvSZ1159Ya4V9lfi1Yi7
 Z/H5fd80dVDeNCpNNn0gFi+Y9F+q5QFQRQ+kwdoXzKpfNR1chnws8kwtdBernDYZy4x6
 S1Jr4N24j1WOxLwt+6UcD82QF4GzvjHbUBlX07Xk/BjjhO2LDsrpwt8i3vK+FpobaT4i ew== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
	by mx0a-000eb902.pphosted.com with ESMTP id 363w1pm5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 19 Jan 2021 14:59:45 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGfT9wrADZqOXlGnyJaa/RoGjhI1fXH4+wThJqWxhrzbTd15G9mm/ImtEN3vJEboeBfQdcwhaDrk6SyubnaaRG2e78u0FxvtijpN2FOlUa8WBvvuJuOAludk9xdPfO8nOGuAw7EnMKbAiokmj/64eWkZ/VtKX7F/Uu4eFf8TmUKGTSH3k1+U5IYrLL88SAjshyc2VQVSKFS/OAzmBsSG+BNgjCzhGVLCULr32LiQcbsU5J/U3nIuF+QHrQpeC9vFr027WAcQ20Yu9wBYhNq5q4B6eaJNYbD70VtLID7XOCa/FoP/u+M4aR2vxbUaxiwgDjPgmLCctB+zN+SNig6KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlkW4nbJhXarKQNRP7Mx0uYbVWh2LApkR6x0DI88Ykg=;
 b=aScgP1ddwOL1JQoB0xPdxckynmoltYrAOGO6nHXRboCj+DDC1aZRFYkHeBC7ZbzQDOUK+FnesZUVP+EdpJMCsryVGa90QhuDxK4bBtazgakThGvXf+9DORQA65ZbWdNCspZ5aOXMcpqCIHD9pgWS+xc3npQzdpF6z3BaMTqEzS64dub/K9fzPxGACiHg/HOcvCo9ufX1jkplO3mvl3i+kDSu8nr83RBOoR851lXmr+11nDxbNYxD0jT7TbFT0tFQbMaBNpDyC/XZGZ7tT2LiaAGnB4VvGH25LNDGzDnrzb8V23+KJWRPM4G8dEQKNXzed7DXz3jPDGc1e05pUyzULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlkW4nbJhXarKQNRP7Mx0uYbVWh2LApkR6x0DI88Ykg=;
 b=X64Ms4UMMFxXhHsIjcCi+SzWdzvBXetFks2tigO4kv52CTwiRO0BojvYAEHT2FwHqIj0OPgkCnq60TS4v5rgi+ZgrK6LQJkGDOfTF3qORwTY1OoLb16n0OHLZiIP/i8lZGBG4buF998ck1IJnq2JZpH9T45Z1yp40bZMwnQifk/vl8kHLQNbCj9n4Udm5aV070173smfRWfVs5E8xpVGohArnP44QDUOv4qRDjxkSG55j/yLDAmAqsR1+3tsMXOtTG12+sFfGrnv0RRzrw8SPywJkSDZWNCKcJTnb6OjIiEVLnYy6wn0CnIsmaN08w+G3+pYF62z6dAXiLQp0Nm4iQ==
Received: from CO2PR04CA0106.namprd04.prod.outlook.com (2603:10b6:104:6::32)
 by DM5PR04MB0235.namprd04.prod.outlook.com (2603:10b6:3:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 20:59:44 +0000
Received: from MW2NAM10FT035.eop-nam10.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::7) by CO2PR04CA0106.outlook.office365.com
 (2603:10b6:104:6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12 via Frontend
 Transport; Tue, 19 Jan 2021 20:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 MW2NAM10FT035.mail.protection.outlook.com (10.13.154.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 19 Jan 2021 20:59:43 +0000
Received: from OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2106.2; Tue, 19 Jan 2021 14:59:36 -0600
Received: from OLA-JP0QR33.garmin.com (10.5.84.15) by
 OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 19 Jan 2021 14:59:42 -0600
From: matt.hoosier@garmin.com
To: <bitbake-devel@lists.openembedded.org>
CC: Matt Hoosier <matt.hoosier@garmin.com>
Subject: [PATCH] fetch/git: download LFS content too during do_fetch
Date: Tue, 19 Jan 2021 14:59:34 -0600
Message-ID: <20210119205934.24174-1-matt.hoosier@garmin.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-ClientProxiedBy: OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) To
 OLAWPA-EXMB8.ad.garmin.com (10.5.144.18)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec02c292-7888-4def-7bd6-08d8bcbd2577
X-MS-TrafficTypeDiagnostic: DM5PR04MB0235:
X-Microsoft-Antispam-PRVS: 
	<DM5PR04MB02350ADC78C466F67AE6B8C9ECA39@DM5PR04MB0235.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ir5bgDJ4O20mauAuHfgPeargSxWwBQ3C3odH1UchnEUy+5f+MN/IysjUtC5C0xCq7hlbGkByL4xRiaaGh0b7tfdMy0iGevQyHpQLUfRKxZPNkVc/Pohp9D6qQ1rFPmJn2zYQa3hf1xLLR1GCOKIPXSpjMh6+uOiWlftpU1AnqF4OiEvlWi2fl1tJeG4qipOn64spJ88jeOIk7yu1Kk1eTCoTtR6MNgks/igUDn3Xk55jzK4Wr1dhbyesq5jo6w6ETxsczYB3hjYlv3knVJ0azNtEi0/uOan4m6rh+Do/ZYnMapBVryL/698rYi5RA8SBC2xLIZgRPp0Nbq0U3Hm7i8qFuQX3x3fnneUBV3N5XHCFjOIRdfOFrTU7A58TflAc5cJEX7vxscyhx/6DpRDpwQlt11ueIuQrs5reK+JPKU6FM3Q+lvf4cdv2c83BEvyISRv0anqBnnZgDhJ8Hd2wlQ==
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(46966006)(2906002)(82740400003)(7636003)(186003)(44832011)(83380400001)(2616005)(6916009)(316002)(336012)(6666004)(7696005)(5660300002)(478600001)(26005)(1076003)(426003)(356005)(8936002)(70206006)(4326008)(36756003)(8676002)(70586007)(107886003)(86362001)(82310400003)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:59:43.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec02c292-7888-4def-7bd6-08d8bcbd2577
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW2NAM10FT035.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0235
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_09:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=963 suspectscore=0 clxscore=1011
 adultscore=100 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190115
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Insert an explicit call-out to git-lfs to fetch all blobs needed by
each ref named in SRC_URI, during the fetch() function. This avoids
the default behavior of Git LFS to wait until 'git checkout' to
begin downloading the blobs pointed to by LFS records. Network
access is not allowed at that point in the recipe's lifecycle.

Signed-off-by: Matt Hoosier <matt.hoosier@garmin.com>
---
 bitbake/lib/bb/fetch2/git.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index d255afeb36..847d7ff5cc 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -378,6 +378,10 @@ class Git(FetchMethod):
             if missing_rev:
                 raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
 
+        if self._contains_lfs(ud, d, ud.clonedir) and self._need_lfs(ud):
+            for name in ud.names:
+                runfetchcmd("git-lfs fetch origin %s" % ud.revisions[name], d, workdir=ud.clonedir)
+
     def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
@@ -473,7 +477,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        need_lfs = ud.parm.get("lfs", "1") == "1"
+        need_lfs = self._need_lfs(ud)
 
         if not need_lfs:
             ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
@@ -562,6 +566,9 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _need_lfs(self, ud):
+        return ud.parm.get("lfs", "1") == "1"
+
     def _contains_lfs(self, ud, d, wd):
         """
         Check if the repository has 'lfs' (large file) content
@@ -572,8 +579,14 @@ class Git(FetchMethod):
         else:
             branchname = "master"
 
-        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
-            ud.basecmd, ud.branches[ud.names[0]])
+        # The bare clonedir doesn't use the remote names; it has the branch immediately.
+        if wd == ud.clonedir:
+            refname = ud.branches[ud.names[0]]
+        else:
+            refname = "origin/%s" % ud.branches[ud.names[0]]
+
+        cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
+            ud.basecmd, refname)
 
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
-- 
2.30.0

