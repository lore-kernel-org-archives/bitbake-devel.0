Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC07C433FE
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 16:47:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.162.1667839634367713402
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Nov 2022 08:47:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=phFZk7m4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8310cc442d=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7AVtng015476
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Nov 2022 16:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=/JgINz+NuWyBXr9SFSEmgMSvKIks5xD7z5+HOqdC2jI=;
 b=phFZk7m4MWSMN4TFCPt5Kgm3xcbTjmz42O8K+vMiJNsw8LPi5aWH2Ih7ECciFKKgZ5cH
 RdxyrOVudX/aCMJeO9+JrqqwV4tW5iOCAJG68ZlWkkmYQm5i5gvvEBRgsPB/mYSSEsSU
 OB6RtXKsHhvIHzO2VGj5yEcWmhhn2EKhSjll5PsPXLsJide+4HSGOROAtsbaaTJl+4nb
 UA2bW8ERoKQPV7skLgkslddl4C+AHIgp82OfenCOKLmItwkEYH8vRu6NGhJGmZfVYeWN
 Gip9HiehTqU8L1QcIIAOTjtqkq1gR+c4v0BWA1tNwJwW1dsPjPw8o1YgVcyzveDQ6Sn3 SQ== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3knd21hwyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 07 Nov 2022 16:47:13 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 7 Nov 2022 08:47:05 -0800
Received: from yow-dellw-ma.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 7 Nov 2022 08:47:05 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] data_smart: allow python snippets to include a dictionary
Date: Mon, 7 Nov 2022 11:46:52 -0500
Message-ID: <20221107164652.435071-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5Lg91mhR5P_r94X1j-tTgWfqijetz7Sl
X-Proofpoint-ORIG-GUID: 5Lg91mhR5P_r94X1j-tTgWfqijetz7Sl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070134
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Nov 2022 16:47:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14058

[YOCTO #14917]

Attempting to use a dictionary in a python code snippet for variable
assignment results in an error. For example attempting something such
as

  IDX = "green"
  VAL = "${@{ 'green': 1, 'blue': 2 }[d.getVar('IDX')]}"

produces the error

  expansion of VAL threw ExpansionError: Failure expanding variable
  VAL, expression was ${@{ 'green': 1, 'blue': 2 }[d.getVar('IDX')]}
  which triggered exception SyntaxError: '{' was never closed (Var
  <VAL>, line 1)

The existing __expand_python_regexp__, "\${@.+?}", will match the
first close curly bracket encountered, resulting in incomplete and
un-parsable code, and thus produce the error. We can correct this by
allowing a single depth of nested curly brackets in
__expand_python_regexp__ by using "\${@(?:{.*?}|.)+?}", which will
match up to and including the matching close curly bracket to the
open, '${@', curly bracket, even if there are one or more singly
nested curly brackets present. This change allows the usecase
described above to function.

This change can't be made on its own though. The old regex would, in
an obscure way, handle the case where a python snippet contained an
unexpandable variable. Since the unexpandable variable is in curly
brackets it would cause incomplete/un-parsable python code and thus
remain unparsed. So something like

  VAL = "${@d.getVar('foo') + ${unsetvar}}"

would remain unparsed as the close curly bracket in "${unsetvar}"
would match and terminate the snippet prematurely. This quirk resulted
in the proper handling of python snippets with unexpanded
variables. With the change to __expand_python_regexp__ the full
snippet will match and be parsed, but to match the old/correct
behavior we would not want to parse it until ${unsetvar} can be
expanded. To ensure the old/correct behavior for python snippets with
unexpanded variables remains in place we add a check for unexpanded
variables in the python snippets before running them.

This handling of unparsed variables brings two benefits. The first we
now have an explicit check visible to all for unexpanded variables
instead of a somewhat hidden behavior. The second is that if there are
multiple python snippets the old behavior would run the code for each
but a single snippet with unexpanded variables would mean all snippets
would remain unparsed, meaning more and repeated processing at a later
time.

For example:
  "${@2*2},${@d.getVar('foo') ${unsetvar}}"
old behavior would give:
  "${@2*2},${@d.getVar('foo') ${unsetvar}}"
new behavior will give:
  "4,${@d.getVar('foo') ${unsetvar}}"

The old behavior would calculate '2*2' but toss the result when the
second snippet would fail to parse resulting in future recalculations
(or fetching from cache), while the new behavior avoids this.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/data_smart.py | 7 ++++++-
 lib/bb/tests/data.py | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index dd20ca55..62d0c01c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -29,7 +29,7 @@ logger = logging.getLogger("BitBake.Data")
 __setvar_keyword__ = [":append", ":prepend", ":remove"]
 __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
-__expand_python_regexp__ = re.compile(r"\${@.+?}")
+__expand_python_regexp__ = re.compile(r"\${@(?:{.*?}|.)+?}")
 __whitespace_split__ = re.compile(r'(\s)')
 __override_regexp__ = re.compile(r'[a-z0-9]+')
 
@@ -119,6 +119,11 @@ class VariableParse:
             else:
                 code = match.group()[3:-1]
 
+            # Do not run code that contains one or more unexpanded variables
+            # instead return the code with the characters we removed put back
+            if __expand_var_regexp__.findall(code):
+                return "${@" + code + "}"
+
             if self.varname:
                 varname = 'Var <%s>' % self.varname
             else:
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index e667c7c7..8c043b70 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -60,6 +60,15 @@ class DataExpansions(unittest.TestCase):
         val = self.d.expand("${@5*12}")
         self.assertEqual(str(val), "60")
 
+    def test_python_snippet_w_dict(self):
+        val = self.d.expand("${@{ 'green': 1, 'blue': 2 }['green']}")
+        self.assertEqual(str(val), "1")
+
+    def test_python_unexpanded_multi(self):
+        self.d.setVar("bar", "${unsetvar}")
+        val = self.d.expand("${@2*2},${foo},${@d.getVar('foo') + ' ${bar}'},${foo}")
+        self.assertEqual(str(val), "4,value_of_foo,${@d.getVar('foo') + ' ${unsetvar}'},value_of_foo")
+
     def test_expand_in_python_snippet(self):
         val = self.d.expand("${@'boo ' + '${foo}'}")
         self.assertEqual(str(val), "boo value_of_foo")
-- 
2.25.1


