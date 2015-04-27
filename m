Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 0298265CAC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 16:15:39 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 27 Apr 2015 09:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,658,1422950400"; d="scan'208";a="562546888"
Received: from mlopezva-mobl2.zpn.intel.com (HELO [10.219.24.81])
	([10.219.24.81])
	by orsmga003.jf.intel.com with ESMTP; 27 Apr 2015 09:15:27 -0700
Message-ID: <553E609E.2090608@linux.intel.com>
Date: Mon, 27 Apr 2015 11:15:26 -0500
From: Mariano Lopez <mariano.lopez@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: fetch2/git: Add URL when latest_revision generates an exception.
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
X-List-Received-Date: Mon, 27 Apr 2015 16:15:40 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The URL is not sent when _latest_revision generates and exception.
When performing the sanity checks it is not possible to know the URI 
that failed.

This add the URL when latest_revision generates an exception.

Please disregard previous patch with the same topic.

[YOCTO: #7592]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
  bitbake/lib/bb/fetch2/git.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0fd9bee..0d91431 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -352,7 +352,7 @@ class Git(FetchMethod):
              for l in output.split('\n'):
                  if s in l:
                      return l.split()[0]
-        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream 
git repository in git ls-remote output" % ud.unresolvedrev[name])
+        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream 
git repository in git ls-remote output for %s" % 
(ud.unresolvedrev[name], ud.host+ud.path))

      def latest_versionstring(self, ud, d):
          """
-- 
1.8.4.5

