Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
	by mail.openembedded.org (Postfix) with ESMTP id 4DB7861013
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Aug 2013 08:35:53 +0000 (UTC)
Received: by mail-ee0-f53.google.com with SMTP id b15so2932727eek.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Aug 2013 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=rlrSZzevEldadbNWQZJfdVFamj2SxUl7iU44Li3EYf4=;
	b=FQG0OglwmCufON1gQ3Ri40MxUEf03IzPkFZ9pesEM/yG1WwfjQDTsX2q9tntG33Du9
	wPNHi5cKHu3Nid8v4Jj9wJuFba+kVHgE9zStQ/ZwnXZLdAYgJ1NhK6h+q0NIhtTHWqi/
	rPymXCF4+WD/jlcTbh6C6zdNSkdUL2BsA/gWy6Fsw9lK1KCrgtqnPuuMev9LjDu1E4Xw
	uiVIvEJCJQ9zX5SiDxtVgyY1YpwjI6ZQ/ztRKIL81p52jZMaqvDGtXZS69LfigxmNQMe
	DwLBQWDfHbcr2xMpGAwlyoCkCWvyNO/HWeVb+ds3NLSeDqv2TifgyJmW37izzDEoDlQC
	5afQ==
X-Received: by 10.14.223.199 with SMTP id v47mr20535328eep.32.1376210152965;
	Sun, 11 Aug 2013 01:35:52 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	r48sm39183471eev.14.2013.08.11.01.35.52 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sun, 11 Aug 2013 01:35:52 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 11 Aug 2013 10:36:37 +0200
Message-Id: <1376210197-10265-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [RFC] WIP: git: prefix with refs/tags/ when revision isn't git hash
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
X-List-Received-Date: Sun, 11 Aug 2013 08:35:53 -0000

* many Open webOS components have tag in format
  submissions/N, versions/X.Y.Z
  just by chance I've noticed that git ls-remote behaves a bit different
  than what I've expected:

  We were using tag=18 in SRC_URI.
  librolegen repository doesn't have tag '18'
  $ git tag -l
  submissions/0
  submissions/16
  submissions/17
  submissions/18
  version/2.0.0
  versions/2.1.0

  It was working correctly until now, just because we were lucky.

  From git help ls-remote:
    When <refs>... are specified, only references matching the given
    patterns are displayed.
  $ git ls-remote git://github.com/openwebos/librolegen 18
    cbedc69733f65cd2f498787a621c014e219d38ab        refs/tags/submissions/18
  $ git ls-remote git://github.com/openwebos/librolegen 17
    af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/submissions/17
  $ git ls-remote git://github.com/openwebos/librolegen
    9040954a24115b05219e7dd459dcf91ad05cc739        HEAD
    9040954a24115b05219e7dd459dcf91ad05cc739        refs/heads/master
    85524970dba46557d3c9672455a4a88165efe7f1        refs/notes/review
    fe509e33f5d68c834bce087dff0f6c801d869b68        refs/tags/submissions/0
    04bc2c24ce628de3ac0fba8afce088f2391f96bb        refs/tags/submissions/0^{}
    7aa394eea6bd76618337772894f7615d0ae8e13a        refs/tags/submissions/16
    af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/submissions/17
    cbedc69733f65cd2f498787a621c014e219d38ab        refs/tags/submissions/18
    9040954a24115b05219e7dd459dcf91ad05cc739        refs/tags/submissions/18^{}
    7aa394eea6bd76618337772894f7615d0ae8e13a        refs/tags/version/2.0.0
    af5b0e7b514938d5589c89ab9508ad23dce43e98        refs/tags/versions/2.1.0

    So if someone creates tag 'foo/18' ls-remote will return both lines and
    build will fail.

    Prefixing with 'refs/tags/' will work in this case, but I haven't tested
    if this code breaks AUTOREV or other use-cases -> that's why it's RFC + WIP.

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6175e4c..ebb5722 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -124,7 +124,7 @@ class Git(FetchMethod):
             # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
             if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
                 if ud.revisions[name]:
-                    ud.branches[name] = ud.revisions[name]
+                    ud.branches[name] = "refs/tags/%s" % ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
 
         gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
-- 
1.8.3.2


