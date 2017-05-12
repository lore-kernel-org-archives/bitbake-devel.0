Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
	by mail.openembedded.org (Postfix) with ESMTP id 58C6F77D11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:46 +0000 (UTC)
Received: by mail-pg0-f45.google.com with SMTP id x64so16283313pgd.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=HYh28nm7wtfQU7JGdncmWk1jk6fBGBmFgaqlIyOH1iE=;
	b=iNNB8PL8LIOCeepMPI40d64pEU0jsYtY9NFJywE5ehVQgjyr485AoEp62TVg9eOuYk
	q17Od612ZY0KBl5jaoPzbr4G98U+F+Ah0Uhapr4+7idpNpUArYDM/HODMJRo28qBXMQb
	Iwsh5aq9xIW1jHBVM0y8Q9pPVqN4t6msuHR3YvhrDBjwJtteBck8UZoXvHc8yuugbs8T
	XsYpZFjcrVaq12jf6bxLo3kI0guaBxbPlyrGbj8hsutnaX2OrPXp8WLGHk0BHfS8BKnE
	691xVJ2PnbTQ1brc4ZIJo7c74/K57GUTsW7EFz58XS8g3ZIpZlT6k5MtMOH17reB9k6B
	yBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HYh28nm7wtfQU7JGdncmWk1jk6fBGBmFgaqlIyOH1iE=;
	b=YvEKgciuR6oExHq75II7RW487PiB+OrZVPnekkQhi9StwkbdpZM0wt2XFfKUQ2mxZf
	ldJzcF1j17TRaI0P/U8A+Tua1Cr39dzIpMlBU3B8J7u5ZwWq5OW7dEIpYzgPnJTgZa+h
	4XS0eFvFiB+MtX+rI3limKfo3fofoz4rKGspE+E4UithwsKUTF08Gf09yMw8+KSatMPR
	P5v1UsgjnE4IDJ2bf0kSUqf49uP+1st6xFazf3MkIBFEsI04br0knrwFr5XEEnACf1na
	Zw3XfVKDsX4icFCrTHcfVcvNX0Kh2O18VdkItSZ5KxRzOzLABBygdKJangwm4SfNuztg
	fSyw==
X-Gm-Message-State: AODbwcAoOdXzxFriswY7EPgJVfoLCm+BvAS/IaSJSA/AjMdjChw3p1sQ
	txCf1Cho7TVwOg==
X-Received: by 10.99.60.81 with SMTP id i17mr6533068pgn.183.1494625607317;
	Fri, 12 May 2017 14:46:47 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:46 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:27 +0500
Message-Id: <c3f2c1773900f6f0282d72861802d540cf59018f.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/8] git-make-shallow: add script to make a git repo shallow
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
X-List-Received-Date: Fri, 12 May 2017 21:46:46 -0000

This script will be used by the git fetcher to create shallow mirror tarballs.

    usage: git-make-shallow [-h] [--ref REF] [--shrink] REVISION [REVISION ...]

    Remove the history of the specified revisions, then optionally filter the
    available refs to those specified.

    positional arguments:
      REVISION           a git revision/commit

    optional arguments:
      -h, --help         show this help message and exit
      --ref REF, -r REF  remove all but the specified refs (cumulative)
      --shrink, -s       shrink the git repository by repacking and pruning

While git does provide the ability to clone at a specific depth, and fetch all
remote refs at a particular depth, the depth is across all branches/tags, and
doesn't provide the flexibility we need, hence this script.

Refs (branches+tags) can be filtered, as the process of history removal scales
up rapidly with the number of refs. Even the existing `git fetch --depth=` is
extremely slow on an upstream kernel repository with all the branches and tags
kept.

This uses the same underlying mechanism to implement the history removal which
git itself uses (.git/shallow), and the results, when configured similarly, are
in line with the results git itself produces with `fetch --depth`.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bin/git-make-shallow  | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py | 127 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100755 bin/git-make-shallow

diff --git a/bin/git-make-shallow b/bin/git-make-shallow
new file mode 100755
index 00000000..296d3a3d
--- /dev/null
+++ b/bin/git-make-shallow
@@ -0,0 +1,165 @@
+#!/usr/bin/env python3
+"""git-make-shallow: make the current git repository shallow
+
+Remove the history of the specified revisions, then optionally filter the
+available refs to those specified.
+"""
+
+import argparse
+import collections
+import errno
+import itertools
+import os
+import subprocess
+import sys
+
+version = 1.0
+
+
+def main():
+    if sys.version_info < (3, 4, 0):
+        sys.exit('Python 3.4 or greater is required')
+
+    git_dir = check_output(['git', 'rev-parse', '--git-dir']).rstrip()
+    shallow_file = os.path.join(git_dir, 'shallow')
+    if os.path.exists(shallow_file):
+        try:
+            check_output(['git', 'fetch', '--unshallow'])
+        except subprocess.CalledProcessError:
+            try:
+                os.unlink(shallow_file)
+            except OSError as exc:
+                if exc.errno != errno.ENOENT:
+                    raise
+
+    args = process_args()
+    revs = check_output(['git', 'rev-list'] + args.revisions).splitlines()
+
+    make_shallow(shallow_file, args.revisions, args.refs)
+
+    ref_revs = check_output(['git', 'rev-list'] + args.refs).splitlines()
+    remaining_history = set(revs) & set(ref_revs)
+    for rev in remaining_history:
+        if check_output(['git', 'rev-parse', '{}^@'.format(rev)]):
+            sys.exit('Error: %s was not made shallow' % rev)
+
+    filter_refs(args.refs)
+
+    if args.shrink:
+        shrink_repo(git_dir)
+        subprocess.check_call(['git', 'fsck', '--unreachable'])
+
+
+def process_args():
+    # TODO: add argument to automatically keep local-only refs, since they
+    # can't be easily restored with a git fetch.
+    parser = argparse.ArgumentParser(description='Remove the history of the specified revisions, then optionally filter the available refs to those specified.')
+    parser.add_argument('--ref', '-r', metavar='REF', action='append', dest='refs', help='remove all but the specified refs (cumulative)')
+    parser.add_argument('--shrink', '-s', action='store_true', help='shrink the git repository by repacking and pruning')
+    parser.add_argument('revisions', metavar='REVISION', nargs='+', help='a git revision/commit')
+    if len(sys.argv) < 2:
+        parser.print_help()
+        sys.exit(2)
+
+    args = parser.parse_args()
+
+    if args.refs:
+        args.refs = check_output(['git', 'rev-parse', '--symbolic-full-name'] + args.refs).splitlines()
+    else:
+        args.refs = get_all_refs(lambda r, t, tt: t == 'commit' or tt == 'commit')
+
+    args.refs = list(filter(lambda r: not r.endswith('/HEAD'), args.refs))
+    args.revisions = check_output(['git', 'rev-parse'] + ['%s^{}' % i for i in args.revisions]).splitlines()
+    return args
+
+
+def check_output(cmd, input=None):
+    return subprocess.check_output(cmd, universal_newlines=True, input=input)
+
+
+def make_shallow(shallow_file, revisions, refs):
+    """Remove the history of the specified revisions."""
+    for rev in follow_history_intersections(revisions, refs):
+        print("Processing %s" % rev)
+        with open(shallow_file, 'a') as f:
+            f.write(rev + '\n')
+
+
+def get_all_refs(ref_filter=None):
+    """Return all the existing refs in this repository, optionally filtering the refs."""
+    ref_output = check_output(['git', 'for-each-ref', '--format=%(refname)\t%(objecttype)\t%(*objecttype)'])
+    ref_split = [tuple(iter_extend(l.rsplit('\t'), 3)) for l in ref_output.splitlines()]
+    if ref_filter:
+        ref_split = (e for e in ref_split if ref_filter(*e))
+    refs = [r[0] for r in ref_split]
+    return refs
+
+
+def iter_extend(iterable, length, obj=None):
+    """Ensure that iterable is the specified length by extending with obj."""
+    return itertools.islice(itertools.chain(iterable, itertools.repeat(obj)), length)
+
+
+def filter_refs(refs):
+    """Remove all but the specified refs from the git repository."""
+    all_refs = get_all_refs()
+    to_remove = set(all_refs) - set(refs)
+    if to_remove:
+        check_output(['xargs', '-0', '-n', '1', 'git', 'update-ref', '-d', '--no-deref'],
+                     input=''.join(l + '\0' for l in to_remove))
+
+
+def follow_history_intersections(revisions, refs):
+    """Determine all the points where the history of the specified revisions intersects the specified refs."""
+    queue = collections.deque(revisions)
+    seen = set()
+
+    for rev in iter_except(queue.popleft, IndexError):
+        if rev in seen:
+            continue
+
+        parents = check_output(['git', 'rev-parse', '%s^@' % rev]).splitlines()
+
+        yield rev
+        seen.add(rev)
+
+        if not parents:
+            continue
+
+        check_refs = check_output(['git', 'merge-base', '--independent'] + sorted(refs)).splitlines()
+        for parent in parents:
+            for ref in check_refs:
+                print("Checking %s vs %s" % (parent, ref))
+                try:
+                    merge_base = check_output(['git', 'merge-base', parent, ref]).rstrip()
+                except subprocess.CalledProcessError:
+                    continue
+                else:
+                    queue.append(merge_base)
+
+
+def iter_except(func, exception, start=None):
+    """Yield a function repeatedly until it raises an exception."""
+    try:
+        if start is not None:
+            yield start()
+        while True:
+            yield func()
+    except exception:
+        pass
+
+
+def shrink_repo(git_dir):
+    """Shrink the newly shallow repository, removing the unreachable objects."""
+    subprocess.check_call(['git', 'reflog', 'expire', '--expire-unreachable=now', '--all'])
+    subprocess.check_call(['git', 'repack', '-ad'])
+    try:
+        os.unlink(os.path.join(git_dir, 'objects', 'info', 'alternates'))
+    except OSError as exc:
+        if exc.errno != errno.ENOENT:
+            raise
+    subprocess.check_call(['git', 'prune', '--expire', 'now'])
+
+
+if __name__ == '__main__':
+    main()
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0fd2c021..510071d2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -852,3 +852,130 @@ class FetchCheckStatusTest(FetcherTest):
                 self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
             connection_cache.close_connections()
+
+
+class GitMakeShallowTest(FetcherTest):
+    bitbake_dir = os.path.join(os.path.dirname(os.path.join(__file__)), '..', '..', '..')
+    make_shallow_path = os.path.join(bitbake_dir, 'bin', 'git-make-shallow')
+
+    def setUp(self):
+        FetcherTest.setUp(self)
+        self.gitdir = os.path.join(self.tempdir, 'gitshallow')
+        bb.utils.mkdirhier(self.gitdir)
+        bb.process.run('git init', cwd=self.gitdir)
+
+    def assertRefs(self, expected_refs):
+        actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
+        full_expected = self.git(['rev-parse', '--symbolic-full-name'] + expected_refs).splitlines()
+        self.assertEqual(sorted(full_expected), sorted(actual_refs))
+
+    def assertRevCount(self, expected_count, args=None):
+        if args is None:
+            args = ['HEAD']
+        revs = self.git(['rev-list'] + args)
+        actual_count = len(revs.splitlines())
+        self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
+
+    def git(self, cmd):
+        if isinstance(cmd, str):
+            cmd = 'git ' + cmd
+        else:
+            cmd = ['git'] + cmd
+        return bb.process.run(cmd, cwd=self.gitdir)[0]
+
+    def make_shallow(self, args=None):
+        if args is None:
+            args = ['HEAD']
+        return bb.process.run([self.make_shallow_path] + args, cwd=self.gitdir)
+
+    def add_empty_file(self, path, msg=None):
+        if msg is None:
+            msg = path
+        open(os.path.join(self.gitdir, path), 'w').close()
+        self.git(['add', path])
+        self.git(['commit', '-m', msg, path])
+
+    def test_make_shallow_single_branch_no_merge(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2)
+        self.make_shallow()
+        self.assertRevCount(1)
+
+    def test_make_shallow_single_branch_one_merge(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('checkout -b a_branch')
+        self.add_empty_file('c')
+        self.git('checkout master')
+        self.add_empty_file('d')
+        self.git('merge --no-ff --no-edit a_branch')
+        self.git('branch -d a_branch')
+        self.add_empty_file('e')
+        self.assertRevCount(6)
+        self.make_shallow(['HEAD~2'])
+        self.assertRevCount(5)
+
+    def test_make_shallow_at_merge(self):
+        self.add_empty_file('a')
+        self.git('checkout -b a_branch')
+        self.add_empty_file('b')
+        self.git('checkout master')
+        self.git('merge --no-ff --no-edit a_branch')
+        self.git('branch -d a_branch')
+        self.assertRevCount(3)
+        self.make_shallow()
+        self.assertRevCount(1)
+
+    def test_make_shallow_annotated_tag(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('tag -a -m a_tag a_tag')
+        self.assertRevCount(2)
+        self.make_shallow(['a_tag'])
+        self.assertRevCount(1)
+
+    def test_make_shallow_multi_ref(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('checkout -b a_branch')
+        self.add_empty_file('c')
+        self.git('checkout master')
+        self.add_empty_file('d')
+        self.git('checkout -b a_branch_2')
+        self.add_empty_file('a_tag')
+        self.git('tag a_tag')
+        self.git('checkout master')
+        self.git('branch -D a_branch_2')
+        self.add_empty_file('e')
+        self.assertRevCount(6, ['--all'])
+        self.make_shallow()
+        self.assertRevCount(5, ['--all'])
+
+    def test_make_shallow_multi_ref_trim(self):
+        self.add_empty_file('a')
+        self.git('checkout -b a_branch')
+        self.add_empty_file('c')
+        self.git('checkout master')
+        self.assertRevCount(1)
+        self.assertRevCount(2, ['--all'])
+        self.assertRefs(['master', 'a_branch'])
+        self.make_shallow(['-r', 'master', 'HEAD'])
+        self.assertRevCount(1, ['--all'])
+        self.assertRefs(['master'])
+
+    def test_make_shallow_noop(self):
+        self.add_empty_file('a')
+        self.assertRevCount(1)
+        self.make_shallow()
+        self.assertRevCount(1)
+
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        print("Unset BB_SKIP_NETTESTS to run network tests")
+    else:
+        def test_make_shallow_bitbake(self):
+            self.git('remote add origin https://github.com/openembedded/bitbake')
+            self.git('fetch --tags origin')
+            orig_revs = len(self.git('rev-list --all').splitlines())
+            self.make_shallow(['refs/tags/1.10.0'])
+            self.assertRevCount(orig_revs - 1746, ['--all'])
-- 
2.11.1


