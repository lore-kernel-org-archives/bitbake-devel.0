Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
	by mail.openembedded.org (Postfix) with ESMTP id 7DBF57DDCC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 13:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Y0pvfRGdvTTm076ws1BF5bMH/x2Gr1IFl2r1gfHTUl+QeuF7Vo1VUyXjCy5gz9CWFGIbPC136zRGOJ9Y2n7M+h76SdBFpfkyIJ1C83sACH+ZtxloUhBpf/G7lbat9Vdu2FQ1pkRnOwKsb6UiMnVm61f2hQ1lNGwCBQNU6FKEDCAYypxa3WpfcERdzV1rPDf3RyVfdqVNfthNrhd8XSCoYTk6CcvDwC2xLWwmKlvNalPgBL2DB863NFbZz3if87AU9Vl7bZXPUTJ4vINSu0wwATdGlLwIroTQJ/qG+7GBKJyOnrGz77WAcL18KT88Lf1SqYWAlakzvFJhjw0W1bgasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=G42bbYWOfypgBqjGIqCiXJ+nAJ9Is8pyGz6PpucPa1w=;
	b=K2Csy3HhNMYwZTefk2gJYzMp4Uo8cb643zl43vB+U2Exyf1q0AY3Yzxms+Zivthnvixn58Wk5mm1eH1fT0DUdKDT+ijr9Jf/v5ZqGrTpXxs+BQPUjvE63Vuz6v0Llg+Mw+U5t6GtIQhYrY1D4rBGqMHIDgyT/UHDVSL9sY1hvekHqIJBPK2fHey7fa/jIrnn013WIcGMsKtYMHAn7DKvoe3sjBWxZPQptEosZp4A8+TsS3XUpkbXRxrlMaQhS2OkmQHSRjP0MsrCNTp0Wxj8+w5UFujZnXaZ4xNbD1qMDjeyDt5+iS+SRski/iH4wCQxLLq32FXDSCsBYIYY4kS4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=G42bbYWOfypgBqjGIqCiXJ+nAJ9Is8pyGz6PpucPa1w=;
	b=n9Gu6VEgnP7pSKRshNlB2uiiUYBRYvGKudBC6NMP6zgz1KSEwEHBf6Hr42aVNMFRdkPvwo7P4IKDXqXb1G2fKP+7AxMdmmyHnKLev34J2HuFY5f8gEL/fz/YgpaI+g+HP3HrsvzS9e2SdcAgm5uw8Y/aGwqAJKs3KmTCXbZOCBM=
Received: from DM3PR12CA0101.namprd12.prod.outlook.com (2603:10b6:0:55::21) by
	DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.16; Fri, 26 Jul 2019 13:54:49 +0000
Received: from BY2NAM05FT061.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::203) by DM3PR12CA0101.outlook.office365.com
	(2603:10b6:0:55::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14 via
	Frontend Transport; Fri, 26 Jul 2019 13:54:49 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	BY2NAM05FT061.mail.protection.outlook.com (10.152.100.198) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.7 via Frontend Transport; Fri, 26 Jul 2019 13:54:49 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Fri, 26 Jul 2019 07:54:39 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Jul 2019 09:54:08 -0400
Message-ID: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(189003)(29502001)(199004)(486006)(36756003)(2351001)(47776003)(4326008)(6916009)(49486002)(5660300002)(107886003)(50226002)(316002)(6666004)(246002)(14444005)(51416003)(70206006)(7636002)(50466002)(476003)(956004)(8936002)(305945005)(2616005)(336012)(126002)(86362001)(8676002)(26005)(426003)(2906002)(186003)(478600001)(106002)(48376002)(356004)(44832011)(16586007)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1660;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg1.windmz.agilent.com,cos.smtp.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48872140-c689-421e-ca0c-08d711d0d366
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:DM5PR12MB1660; 
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1660F1259CC469E36CDB06348BC00@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 01106E96F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4qWSIKGlJ72iBB0JB1wgwJFg47A14qtDYH41ry8T6CiTgbv/o78d1hzEzYnTUyI36T1T/QLZnppDLWrtQH+DQ5Ql33syo5MOwXTY1WGIJT81gBl/VCTBkcFvSmggnD4DZHQWzO+7xJWPbzYAyqXdsHLSktM4LISJlalmbPjz8UpKh8u5h7Gb42+RrZGo0Gc/M5K2qaWisdURfCa7IccYRVUFKp0Cn34Giz1njiZtd4XJb0lL8a/FGOiKHRVGcA2J3hv03j2opYLKmKaCIRLSsQcoltGZZ1+B4wXFVZQwDlwCpCc7FGIv3g7o0xvt8zRzL+P4A3fPjLSO/PhS6rcO5cmHgwnswtU3rmVCALMljyrqnmDEZXt4RqFeFaeMJ/yi3fXtOmTVdmQI1EZhu8JDL7J6IyzY6NeTdQP0RruwCv8=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 13:54:49.2462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48872140-c689-421e-ca0c-08d711d0d366
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
Subject: [PATCH] fetch2: add ability to skip recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
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
X-List-Received-Date: Fri, 26 Jul 2019 13:54:51 -0000
Content-Type: text/plain

Sometimes it is desirable to just skip a recipe if the upstream(s) can't be
accessed by the user, rather than fail the whole build outright.

For example, in a corporate environment, sometimes certain git repositories
are access controlled. If privileged and non-privileged users share
the same Yocto layers, it would be nice for the non-privileged users to
be able to build the recipes they need, without tripping over parse
failures on the non-accessible recipes.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/__init__.py | 99 +++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f6b5529..a165a77 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -741,55 +741,60 @@ def get_srcrev(d, method_name='sortable_revision'):
     that fetcher provides a method with the given name and the same signature as sortable_revision.
     """
 
-    scms = []
-    fetcher = Fetch(d.getVar('SRC_URI').split(), d)
-    urldata = fetcher.ud
-    for u in urldata:
-        if urldata[u].method.supports_srcrev():
-            scms.append(u)
-
-    if len(scms) == 0:
-        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
-
-    if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
-        autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
-        if len(rev) > 10:
-            rev = rev[:10]
-        if autoinc:
-            return "AUTOINC+" + rev
-        return rev
-
-    #
-    # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
-    #
-    format = d.getVar('SRCREV_FORMAT')
-    if not format:
-        raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.\n"\
-                         "The SCMs are:\n%s" % '\n'.join(scms))
-
-    name_to_rev = {}
-    seenautoinc = False
-    for scm in scms:
-        ud = urldata[scm]
-        for name in ud.names:
-            autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
-            seenautoinc = seenautoinc or autoinc
+    try:
+        scms = []
+        fetcher = Fetch(d.getVar('SRC_URI').split(), d)
+        urldata = fetcher.ud
+        for u in urldata:
+            if urldata[u].method.supports_srcrev():
+                scms.append(u)
+
+        if len(scms) == 0:
+            raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
+
+        if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
+            autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
             if len(rev) > 10:
                 rev = rev[:10]
-            name_to_rev[name] = rev
-    # Replace names by revisions in the SRCREV_FORMAT string. The approach used
-    # here can handle names being prefixes of other names and names appearing
-    # as substrings in revisions (in which case the name should not be
-    # expanded). The '|' regular expression operator tries matches from left to
-    # right, so we need to sort the names with the longest ones first.
-    names_descending_len = sorted(name_to_rev, key=len, reverse=True)
-    name_to_rev_re = "|".join(re.escape(name) for name in names_descending_len)
-    format = re.sub(name_to_rev_re, lambda match: name_to_rev[match.group(0)], format)
-
-    if seenautoinc:
-        format = "AUTOINC+" + format
-
-    return format
+            if autoinc:
+                return "AUTOINC+" + rev
+            return rev
+
+        #
+        # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
+        #
+        format = d.getVar('SRCREV_FORMAT')
+        if not format:
+            raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.\n"\
+                             "The SCMs are:\n%s" % '\n'.join(scms))
+
+        name_to_rev = {}
+        seenautoinc = False
+        for scm in scms:
+            ud = urldata[scm]
+            for name in ud.names:
+                autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
+                seenautoinc = seenautoinc or autoinc
+                if len(rev) > 10:
+                    rev = rev[:10]
+                name_to_rev[name] = rev
+        # Replace names by revisions in the SRCREV_FORMAT string. The approach used
+        # here can handle names being prefixes of other names and names appearing
+        # as substrings in revisions (in which case the name should not be
+        # expanded). The '|' regular expression operator tries matches from left to
+        # right, so we need to sort the names with the longest ones first.
+        names_descending_len = sorted(name_to_rev, key=len, reverse=True)
+        name_to_rev_re = "|".join(re.escape(name) for name in names_descending_len)
+        format = re.sub(name_to_rev_re, lambda match: name_to_rev[match.group(0)], format)
+
+        if seenautoinc:
+            format = "AUTOINC+" + format
+
+        return format
+    except FetchError as e:
+        if d.getVar('BB_WORKERCONTEXT') != '1' and bb.utils.to_boolean(d.getVar("BB_FETCH_SKIP_ON_SRCREV_ERROR")):
+            raise bb.parse.SkipRecipe(e)
+        raise
 
 def localpath(url, d):
     fetcher = bb.fetch2.Fetch([url], d)
-- 
2.7.4


