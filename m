Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 599 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 13 Feb 2017 11:48:56 UTC
Received: from smtp685.redcondor.net (smtp685.redcondor.net [208.80.206.85])
	by mail.openembedded.org (Postfix) with ESMTP id F326171DD9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Feb 2017 11:48:56 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp685.redcondor.net ({20c8e40f-6b6c-4c9e-abff-1640ea7bf404})
	via TCP (outbound) with ESMTPS id 20170213113856548_0685
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Feb 2017 03:38:56 -0800
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [216.191.234.70] (port=49494 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1cdEy2-0005sg-JH for bitbake-devel@lists.openembedded.org;
	Mon, 13 Feb 2017 06:38:50 -0500
Date: Mon, 13 Feb 2017 06:38:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@uk63952.mitel.com
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.20.1702130636370.7420@uk63952.mitel.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
X-MAG-EWAV: unavailable
Subject: [PATCH] fetch2: Correct two examples of typo "revsion."
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
X-List-Received-Date: Mon, 13 Feb 2017 11:48:58 -0000
Content-Type: text/plain; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  in comments only, so should have no effect on execution.

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 525f47e..9151238 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -724,7 +724,7 @@ def get_autorev(d):

 def get_srcrev(d, method_name='sortable_revision'):
     """
-    Return the revsion string, usually for use in the version string (PV) of the current package
+    Return the revision string, usually for use in the version string (PV) of the current package
     Most packages usually only have one SCM so we just pass on the call.
     In the multi SCM case, we build a value based on SRCREV_FORMAT which must
     have been set.
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f7a0c01..023b608 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -50,7 +50,7 @@ Supported SRC_URI options are:
    The default is "0", set nobranch=1 if needed.

 - usehead
-   For local git:// urls to use the current branch HEAD as the revsion for use with
+   For local git:// urls to use the current branch HEAD as the revision for use with
    AUTOREV. Implies nobranch.

 """

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


