Return-Path: <andre.draszik@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A2C54788
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 09:55:10 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.38100.1708336509832228094
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 01:55:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Vxzu6qZ3;
 spf=pass (domain: linaro.org, ip: 209.85.208.52, mailfrom: andre.draszik@linaro.org)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5497282a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708336508; x=1708941308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Abcm1hP90aXwSj+fGQORlrMhuUylnD4avqHQsjSbI=;
        b=Vxzu6qZ3DbE0JV9SKXZWFMP05Ac/IFSkOV/Gt9S0hgGXngvOq9bEvsvxcfwtpx4DkD
         fVEXNS7S/QjMCGSnLQS3w9kUoEpXXwELKFdiRP+esRZjezsAdu7mBEYqJBu5WXv6x0cB
         FidR43iouD6J9pp9FAhJ9zHWL7jhoaadyDLicW2iDtKv0t4gwrBvO/fAvp4SXM6+2IuR
         3imsKDujxF9YZn2dYK5BRy12e3dWxUrRYsoG4zd0CF8dPHoXBPljFDwI8/C1xeBivvGB
         kVeTICI9/TFoJFu/8ocKD1BzaPczcZt2pAw5lMwWdlrrYIb4DEUkn9AuVEZMA5xs7mYj
         Thrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336508; x=1708941308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7Abcm1hP90aXwSj+fGQORlrMhuUylnD4avqHQsjSbI=;
        b=HEuSVMcwZtT/O8X2sPzussWHbGe4rdWgRcWYfbJJEalMjTBtAkWIeqMxn6rW0k5X/1
         VHDW4M6AepEHnXNlpvjdD8CcIv40Evlxl27LhQbTacCtXN0yaO70V9mZ0Q78cvOyJAvi
         xmh1rc83Dzb/4QnlHDJjBnaYAA3WgnEcb6oLpL8j0VHqViCm7m+paIrB1Z0ZtifC+YaL
         cpaU2Vm6kLklT6FWEWFVysP6Xnr7Fm5qJ0UfKI6iVw/Y+x9d/N088BQ2cEI1YN9S4wVk
         q1Y/Q8cdcRMLW9XxQ5y6UtdJnM3sCE1Pa5e7OebDeQRBnYyB/M0caEqQreiWCIwpaf3m
         vV3Q==
X-Gm-Message-State: AOJu0YxO5frMeGOEEkXuhPDw1b/VA9xzpryXbB7ZagYV3eTlwfECziuh
	Pb8hOqprlRRWn6OjfbVFfzkQRRlkeiW/UjUQPuvlKptKwldcwYkU/Dx6qJqBfTKTXqab92FzxRK
	h4Dc=
X-Google-Smtp-Source: AGHT+IEdEx59lXmbCl67RBrCqLJRWWDvuXtfxyXEOUNMiWo8aOUpjSqL/wKFsv34LIZ9N/LE+5uubg==
X-Received: by 2002:a05:6402:214a:b0:563:bd95:4ef8 with SMTP id bq10-20020a056402214a00b00563bd954ef8mr7878184edb.23.1708336508244;
        Mon, 19 Feb 2024 01:55:08 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b00563d03030e8sm2527526edm.55.2024.02.19.01.55.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:55:07 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][PATCH 3/3] git-make-shallow: support git's safe.bareRepository
Date: Mon, 19 Feb 2024 09:52:14 +0000
Message-ID: <20240219095454.3211974-4-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219095454.3211974-1-andre.draszik@linaro.org>
References: <20240219095454.3211974-1-andre.draszik@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 09:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15938

When git is configured with safe.bareRepository=explicit [1], the
git-make-shallow fails miserably. LWN has an article about the
problem that this configuration option addresses and why it is useful
in [2].

It also seems that it is being rolled out in some environments as a
default for users.

In order to allow having this configuration turned on for a user's
environment in general, the fetcher has to be tought to use --git-dir=
for all relevent git operations.

The alternative, implemented here, is to forcibly turn off that option
for all git operations. In the future, we could look into converting
these to using the --git-dir= command line argument instead.

Link: https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/config/safe.txt#n1 [1]
Link: https://lwn.net/Articles/892755/ [2]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 bitbake/bin/git-make-shallow | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/bitbake/bin/git-make-shallow b/bitbake/bin/git-make-shallow
index d0532c5ab85e..9de557c10e4a 100755
--- a/bitbake/bin/git-make-shallow
+++ b/bitbake/bin/git-make-shallow
@@ -24,15 +24,17 @@ warnings.simplefilter("default")
 version = 1.0
 
 
+git_cmd = ['git', '-c', 'safe.bareRepository=all']
+
 def main():
     if sys.version_info < (3, 4, 0):
         sys.exit('Python 3.4 or greater is required')
 
-    git_dir = check_output(['git', 'rev-parse', '--git-dir']).rstrip()
+    git_dir = check_output(git_cmd + ['rev-parse', '--git-dir']).rstrip()
     shallow_file = os.path.join(git_dir, 'shallow')
     if os.path.exists(shallow_file):
         try:
-            check_output(['git', 'fetch', '--unshallow'])
+            check_output(git_cmd + ['fetch', '--unshallow'])
         except subprocess.CalledProcessError:
             try:
                 os.unlink(shallow_file)
@@ -41,21 +43,21 @@ def main():
                     raise
 
     args = process_args()
-    revs = check_output(['git', 'rev-list'] + args.revisions).splitlines()
+    revs = check_output(git_cmd + ['rev-list'] + args.revisions).splitlines()
 
     make_shallow(shallow_file, args.revisions, args.refs)
 
-    ref_revs = check_output(['git', 'rev-list'] + args.refs).splitlines()
+    ref_revs = check_output(git_cmd + ['rev-list'] + args.refs).splitlines()
     remaining_history = set(revs) & set(ref_revs)
     for rev in remaining_history:
-        if check_output(['git', 'rev-parse', '{}^@'.format(rev)]):
+        if check_output(git_cmd + ['rev-parse', '{}^@'.format(rev)]):
             sys.exit('Error: %s was not made shallow' % rev)
 
     filter_refs(args.refs)
 
     if args.shrink:
         shrink_repo(git_dir)
-        subprocess.check_call(['git', 'fsck', '--unreachable'])
+        subprocess.check_call(git_cmd + ['fsck', '--unreachable'])
 
 
 def process_args():
@@ -72,12 +74,12 @@ def process_args():
     args = parser.parse_args()
 
     if args.refs:
-        args.refs = check_output(['git', 'rev-parse', '--symbolic-full-name'] + args.refs).splitlines()
+        args.refs = check_output(git_cmd + ['rev-parse', '--symbolic-full-name'] + args.refs).splitlines()
     else:
         args.refs = get_all_refs(lambda r, t, tt: t == 'commit' or tt == 'commit')
 
     args.refs = list(filter(lambda r: not r.endswith('/HEAD'), args.refs))
-    args.revisions = check_output(['git', 'rev-parse'] + ['%s^{}' % i for i in args.revisions]).splitlines()
+    args.revisions = check_output(git_cmd + ['rev-parse'] + ['%s^{}' % i for i in args.revisions]).splitlines()
     return args
 
 
@@ -95,7 +97,7 @@ def make_shallow(shallow_file, revisions, refs):
 
 def get_all_refs(ref_filter=None):
     """Return all the existing refs in this repository, optionally filtering the refs."""
-    ref_output = check_output(['git', 'for-each-ref', '--format=%(refname)\t%(objecttype)\t%(*objecttype)'])
+    ref_output = check_output(git_cmd + ['for-each-ref', '--format=%(refname)\t%(objecttype)\t%(*objecttype)'])
     ref_split = [tuple(iter_extend(l.rsplit('\t'), 3)) for l in ref_output.splitlines()]
     if ref_filter:
         ref_split = (e for e in ref_split if ref_filter(*e))
@@ -113,7 +115,7 @@ def filter_refs(refs):
     all_refs = get_all_refs()
     to_remove = set(all_refs) - set(refs)
     if to_remove:
-        check_output(['xargs', '-0', '-n', '1', 'git', 'update-ref', '-d', '--no-deref'],
+        check_output(['xargs', '-0', '-n', '1'] + git_cmd + ['update-ref', '-d', '--no-deref'],
                      input=''.join(l + '\0' for l in to_remove))
 
 
@@ -126,7 +128,7 @@ def follow_history_intersections(revisions, refs):
         if rev in seen:
             continue
 
-        parents = check_output(['git', 'rev-parse', '%s^@' % rev]).splitlines()
+        parents = check_output(git_cmd + ['rev-parse', '%s^@' % rev]).splitlines()
 
         yield rev
         seen.add(rev)
@@ -134,12 +136,12 @@ def follow_history_intersections(revisions, refs):
         if not parents:
             continue
 
-        check_refs = check_output(['git', 'merge-base', '--independent'] + sorted(refs)).splitlines()
+        check_refs = check_output(git_cmd + ['merge-base', '--independent'] + sorted(refs)).splitlines()
         for parent in parents:
             for ref in check_refs:
                 print("Checking %s vs %s" % (parent, ref))
                 try:
-                    merge_base = check_output(['git', 'merge-base', parent, ref]).rstrip()
+                    merge_base = check_output(git_cmd + ['merge-base', parent, ref]).rstrip()
                 except subprocess.CalledProcessError:
                     continue
                 else:
@@ -159,14 +161,14 @@ def iter_except(func, exception, start=None):
 
 def shrink_repo(git_dir):
     """Shrink the newly shallow repository, removing the unreachable objects."""
-    subprocess.check_call(['git', 'reflog', 'expire', '--expire-unreachable=now', '--all'])
-    subprocess.check_call(['git', 'repack', '-ad'])
+    subprocess.check_call(git_cmd + ['reflog', 'expire', '--expire-unreachable=now', '--all'])
+    subprocess.check_call(git_cmd + ['repack', '-ad'])
     try:
         os.unlink(os.path.join(git_dir, 'objects', 'info', 'alternates'))
     except OSError as exc:
         if exc.errno != errno.ENOENT:
             raise
-    subprocess.check_call(['git', 'prune', '--expire', 'now'])
+    subprocess.check_call(git_cmd + ['prune', '--expire', 'now'])
 
 
 if __name__ == '__main__':
-- 
2.44.0.rc0.258.g7320e95886-goog


