Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 6A1ED605D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Apr 2015 18:20:43 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 23 Apr 2015 11:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,633,1422950400"; d="scan'208";a="718251374"
Received: from mlopezva-mobl2.zpn.intel.com (HELO [10.219.18.203])
	([10.219.18.203])
	by orsmga002.jf.intel.com with ESMTP; 23 Apr 2015 11:20:23 -0700
Message-ID: <553937EB.20104@linux.intel.com>
Date: Thu, 23 Apr 2015 13:20:27 -0500
From: Mariano Lopez <mariano.lopez@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: fetch2/git: Allow HEAD to be searched.
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
X-List-Received-Date: Thu, 23 Apr 2015 18:20:45 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This makes it possble to fetch/search HEAD. This is useful when 
searching for HEAD doing the sanity check.

[YOCTO #7592]

Signed-off-by: mlopezva <mariano.lopez@linux.intel.com>
---
  bitbake/lib/bb/fetch2/git.py | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0d91431..12fb6a2 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -345,6 +345,9 @@ class Git(FetchMethod):
          if ud.unresolvedrev[name][:5] == "refs/":
              head = ud.unresolvedrev[name]
              tag = ud.unresolvedrev[name]
+        elif ud.unresolvedrev[name] == "HEAD":
+            head = ud.unresolvedrev[name]
+            tag = ud.unresolvedrev[name]
          else:
              head = "refs/heads/%s" % ud.unresolvedrev[name]
              tag = "refs/tags/%s" % ud.unresolvedrev[name]
-- 
1.8.4.5


