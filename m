Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3787DFED3C5
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 12:47:47 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20378.1777034857547477197
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Apr 2026 05:47:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=afnXRDQx;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=VqzeRfbM;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0A127A00D5;
	Fri, 24 Apr 2026 08:47:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Apr 2026 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777034856;
	 x=1777121256; bh=Ut5KtZAlG0MgOD4VC4bZmuqrnBSAWMEaMnuklXXutqA=; b=
	afnXRDQxFZ5w4G1eaCR2OBnN+wkCit/FBp5nvQmn3frr/J3HEnU2bEnL/5JZ7kUJ
	IkxXKBdxXtPPzaLpSKpo8/taDdKUZCJlom2HM1MhoSAjx3JkKXQVA6oYfXBM+NjN
	I8+uWOCpFYuIOoGSjyYfcOoghPNowTzLQClziWNjYPzCXLA2BPQhERNpaxZxXYcV
	68zk4njy/UN14dTiIWtWz6QFmA1BmJGZlaOLuAxcAcmANmMa0oXEUfcay2t3Abbn
	RauTSDB1DHlJS9BoepY2pCC0qhGXPM0HSfGhTMVqqgb/OhniM+BZJoJ68fMAL308
	7uPzNdGZZXBKK9CdVOSsgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777034856; x=
	1777121256; bh=Ut5KtZAlG0MgOD4VC4bZmuqrnBSAWMEaMnuklXXutqA=; b=V
	qzeRfbMjF0o8JkYPxVjoQZcw5oEtfPSUpWbGkCKHkgZftOMP3s9P9A0ou9Tr9c25
	Av8eyzHted0HAt93eB2QdDqPTywYvgpujUCocyZAlo0y4Rn6boKUwilUwqjqsuzF
	SRg8TDogo1M2TO5/IoUllupSty7R7esLkSWUv8dKJ4taL3h1mjcSQKHpleLMyttS
	BcrMGFO1UaAaySts+mnnxn23rmsTR8mlVxjNl9Pl2d2Nc9lFyZgX8Qg4N2CdHpw8
	tpzchxzSGQXavEmXp0Zh9N9PL4ivV4X8KEDtI9MyJs6wVNgefgJvFbXa4MjxhEUV
	A1wyR6Gk4LwDHF8N/FdVg==
X-ME-Sender: <xms:aGbraTQLaZ76nF_cb8RvJDhrRkgU3AJQD3XJWPo7XvZNnzzg6tRS8w>
    <xme:aGbracgAhSdL-kMdXvkiUuHiOz4o20p_k-5RpgtxdWxaqwPG9Y2kxTNLssAe2KJ_w
    7AatJYLr27Qbu33waXWV3AXZO5CCbLTQMw9xmRH1y7ctrsZfGb60rA>
X-ME-Received: <xmr:aGbrab6AFuXhAbIt_tMBv5Q5iFNqOS8VZ0G9GgqQbd2C5LcPlatsG3O2j3CgHbo4jDmyuhlqfz4-RCgnF6Q9VmLrMcvHONU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghr
    rdguvghvqeenucggtffrrghtthgvrhhnpeeiteeuleelgfduieejhfdtfeeugfeghfduhe
    egffekieefhedvgeeiudfgfeevgfenucffohhmrghinhepphhrohgtvghsshdrrhhunhdp
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghrkhgvrhdrug
    gvvhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgv
    mhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtoh
    hprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:aGbraRAG-T_aj1Ai9rfjat0y4eIxglwzZnF56Dhc49bkZTE28AhuWw>
    <xmx:aGbraab-DN3wUMyZO7ZenIXVBMkOlz-LAzZpepgJ2nOO6E_8EAo9mA>
    <xmx:aGbraUZRiONgzdCJCSsnwy2e4yNMcwzfMcsGlK95Tdmmw-l5qpnuAw>
    <xmx:aGbraZ-MgWjYu3HG-P865CYD6ftUc8aJ_3-rPi5g8zV-SWShpyjB6w>
    <xmx:aGbraTMZaslncye-Yn48mSWKl-Slp1f3HPfbBlZVGixEUiQB0sDbKV3s>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 08:47:35 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Fri, 24 Apr 2026 13:47:25 +0100
Subject: [PATCH 1/2] Drop git-make-shallow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-make-shallow-v1-1-fc06b12ca344@pbarker.dev>
References: <20260424-make-shallow-v1-0-fc06b12ca344@pbarker.dev>
In-Reply-To: <20260424-make-shallow-v1-0-fc06b12ca344@pbarker.dev>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11538; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=XdF7SE+8Ecqi1m0j9OBRtK27TgbT+SnC8tdpMY4CLQQ=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWS+TksNljnS+qV9dui/y6s2aO8wStE/ZGnK/lO5Oix5o
 bXWzbvBHaUsDGJcDLJiiiybe77ef9rryJsRcksBZg4rE8gQBi5OAZjI2c0M/1O32DmF3eRiYIrU
 eaD4wLBpnuNpBk3jL+tslbzEGEpm/WFk2BgwdfqeUIn7er5S1Tnrlc8uP2S0/3PuI93ORqUfO3y
 1eQE=
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 12:47:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19388

This has been unused since commit a5a569c07522 ("fetch2/git: Use git
shallow fetch to implement clone_shallow_local()"), so drop it and the
associated test cases.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 bin/git-make-shallow  | 175 --------------------------------------------------
 lib/bb/fetch2/git.py  |   1 -
 lib/bb/tests/fetch.py |  87 -------------------------
 3 files changed, 263 deletions(-)

diff --git a/bin/git-make-shallow b/bin/git-make-shallow
deleted file mode 100755
index e6c180b4d657..000000000000
--- a/bin/git-make-shallow
+++ /dev/null
@@ -1,175 +0,0 @@
-#!/usr/bin/env python3
-#
-# Copyright BitBake Contributors
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-"""git-make-shallow: make the current git repository shallow
-
-Remove the history of the specified revisions, then optionally filter the
-available refs to those specified.
-"""
-
-import argparse
-import collections
-import errno
-import itertools
-import os
-import subprocess
-import sys
-import warnings
-warnings.simplefilter("default")
-
-version = 1.0
-
-
-git_cmd = ['git', '-c', 'safe.bareRepository=all']
-
-def main():
-    if sys.version_info < (3, 4, 0):
-        sys.exit('Python 3.4 or greater is required')
-
-    git_dir = check_output(git_cmd + ['rev-parse', '--git-dir']).rstrip()
-    shallow_file = os.path.join(git_dir, 'shallow')
-    if os.path.exists(shallow_file):
-        try:
-            check_output(git_cmd + ['fetch', '--unshallow'])
-        except subprocess.CalledProcessError:
-            try:
-                os.unlink(shallow_file)
-            except OSError as exc:
-                if exc.errno != errno.ENOENT:
-                    raise
-
-    args = process_args()
-    revs = check_output(git_cmd + ['rev-list'] + args.revisions).splitlines()
-
-    make_shallow(shallow_file, args.revisions, args.refs)
-
-    ref_revs = check_output(git_cmd + ['rev-list'] + args.refs).splitlines()
-    remaining_history = set(revs) & set(ref_revs)
-    for rev in remaining_history:
-        if check_output(git_cmd + ['rev-parse', '{}^@'.format(rev)]):
-            sys.exit('Error: %s was not made shallow' % rev)
-
-    filter_refs(args.refs)
-
-    if args.shrink:
-        shrink_repo(git_dir)
-        subprocess.check_call(git_cmd + ['fsck', '--unreachable'])
-
-
-def process_args():
-    # TODO: add argument to automatically keep local-only refs, since they
-    # can't be easily restored with a git fetch.
-    parser = argparse.ArgumentParser(description='Remove the history of the specified revisions, then optionally filter the available refs to those specified.')
-    parser.add_argument('--ref', '-r', metavar='REF', action='append', dest='refs', help='remove all but the specified refs (cumulative)')
-    parser.add_argument('--shrink', '-s', action='store_true', help='shrink the git repository by repacking and pruning')
-    parser.add_argument('revisions', metavar='REVISION', nargs='+', help='a git revision/commit')
-    if len(sys.argv) < 2:
-        parser.print_help()
-        sys.exit(2)
-
-    args = parser.parse_args()
-
-    if args.refs:
-        args.refs = check_output(git_cmd + ['rev-parse', '--symbolic-full-name'] + args.refs).splitlines()
-    else:
-        args.refs = get_all_refs(lambda r, t, tt: t == 'commit' or tt == 'commit')
-
-    args.refs = list(filter(lambda r: not r.endswith('/HEAD'), args.refs))
-    args.revisions = check_output(git_cmd + ['rev-parse'] + ['%s^{}' % i for i in args.revisions]).splitlines()
-    return args
-
-
-def check_output(cmd, input=None):
-    return subprocess.check_output(cmd, universal_newlines=True, input=input)
-
-
-def make_shallow(shallow_file, revisions, refs):
-    """Remove the history of the specified revisions."""
-    for rev in follow_history_intersections(revisions, refs):
-        print("Processing %s" % rev)
-        with open(shallow_file, 'a') as f:
-            f.write(rev + '\n')
-
-
-def get_all_refs(ref_filter=None):
-    """Return all the existing refs in this repository, optionally filtering the refs."""
-    ref_output = check_output(git_cmd + ['for-each-ref', '--format=%(refname)\t%(objecttype)\t%(*objecttype)'])
-    ref_split = [tuple(iter_extend(l.rsplit('\t'), 3)) for l in ref_output.splitlines()]
-    if ref_filter:
-        ref_split = (e for e in ref_split if ref_filter(*e))
-    refs = [r[0] for r in ref_split]
-    return refs
-
-
-def iter_extend(iterable, length, obj=None):
-    """Ensure that iterable is the specified length by extending with obj."""
-    return itertools.islice(itertools.chain(iterable, itertools.repeat(obj)), length)
-
-
-def filter_refs(refs):
-    """Remove all but the specified refs from the git repository."""
-    all_refs = get_all_refs()
-    to_remove = set(all_refs) - set(refs)
-    if to_remove:
-        check_output(git_cmd + ['update-ref', '--no-deref', '--stdin', '-z'],
-                     input=''.join('delete ' + l + '\0\0' for l in to_remove))
-
-
-def follow_history_intersections(revisions, refs):
-    """Determine all the points where the history of the specified revisions intersects the specified refs."""
-    queue = collections.deque(revisions)
-    seen = set()
-
-    for rev in iter_except(queue.popleft, IndexError):
-        if rev in seen:
-            continue
-
-        parents = check_output(git_cmd + ['rev-parse', '%s^@' % rev]).splitlines()
-
-        yield rev
-        seen.add(rev)
-
-        if not parents:
-            continue
-
-        check_refs = check_output(git_cmd + ['merge-base', '--independent'] + sorted(refs)).splitlines()
-        for parent in parents:
-            for ref in check_refs:
-                print("Checking %s vs %s" % (parent, ref))
-                try:
-                    merge_base = check_output(git_cmd + ['merge-base', parent, ref]).rstrip()
-                except subprocess.CalledProcessError:
-                    continue
-                else:
-                    queue.append(merge_base)
-
-
-def iter_except(func, exception, start=None):
-    """Yield a function repeatedly until it raises an exception."""
-    try:
-        if start is not None:
-            yield start()
-        while True:
-            yield func()
-    except exception:
-        pass
-
-
-def shrink_repo(git_dir):
-    """Shrink the newly shallow repository, removing the unreachable objects."""
-    subprocess.check_call(git_cmd + ['reflog', 'expire', '--expire-unreachable=now', '--all'])
-    subprocess.check_call(git_cmd + ['repack', '-ad'])
-    try:
-        os.unlink(os.path.join(git_dir, 'objects', 'info', 'alternates'))
-    except OSError as exc:
-        if exc.errno != errno.ENOENT:
-            raise
-    subprocess.check_call(git_cmd + ['prune', '--expire', 'now'])
-
-
-if __name__ == '__main__':
-    main()
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 21f5f28a0292..10eb63b205c8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -127,7 +127,6 @@ class GitProgressHandler(bb.progress.LineFilterProgressHandler):
 
 class Git(FetchMethod):
     bitbake_dir = os.path.abspath(os.path.join(os.path.dirname(os.path.join(os.path.abspath(__file__))), '..', '..', '..'))
-    make_shallow_path = os.path.join(bitbake_dir, 'bin', 'git-make-shallow')
 
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 077f741e1d37..86dd92992b68 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1627,11 +1627,6 @@ class GitMakeShallowTest(FetcherTest):
         actual_count = len(revs.splitlines())
         self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
 
-    def make_shallow(self, args=None):
-        if args is None:
-            args = ['HEAD']
-        return bb.process.run([bb.fetch2.git.Git.make_shallow_path] + args, cwd=self.gitdir)
-
     def add_empty_file(self, path, msg=None):
         if msg is None:
             msg = path
@@ -1639,88 +1634,6 @@ class GitMakeShallowTest(FetcherTest):
         self.git(['add', path])
         self.git(['commit', '-m', msg, path])
 
-    def test_make_shallow_single_branch_no_merge(self):
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.assertRevCount(2)
-        self.make_shallow()
-        self.assertRevCount(1)
-
-    def test_make_shallow_single_branch_one_merge(self):
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.git('checkout -b a_branch')
-        self.add_empty_file('c')
-        self.git('checkout master')
-        self.add_empty_file('d')
-        self.git('merge --no-ff --no-edit a_branch')
-        self.git('branch -d a_branch')
-        self.add_empty_file('e')
-        self.assertRevCount(6)
-        self.make_shallow(['HEAD~2'])
-        self.assertRevCount(5)
-
-    def test_make_shallow_at_merge(self):
-        self.add_empty_file('a')
-        self.git('checkout -b a_branch')
-        self.add_empty_file('b')
-        self.git('checkout master')
-        self.git('merge --no-ff --no-edit a_branch')
-        self.git('branch -d a_branch')
-        self.assertRevCount(3)
-        self.make_shallow()
-        self.assertRevCount(1)
-
-    def test_make_shallow_annotated_tag(self):
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.git('tag -a -m a_tag a_tag')
-        self.assertRevCount(2)
-        self.make_shallow(['a_tag'])
-        self.assertRevCount(1)
-
-    def test_make_shallow_multi_ref(self):
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.git('checkout -b a_branch')
-        self.add_empty_file('c')
-        self.git('checkout master')
-        self.add_empty_file('d')
-        self.git('checkout -b a_branch_2')
-        self.add_empty_file('a_tag')
-        self.git('tag a_tag')
-        self.git('checkout master')
-        self.git('branch -D a_branch_2')
-        self.add_empty_file('e')
-        self.assertRevCount(6, ['--all'])
-        self.make_shallow()
-        self.assertRevCount(5, ['--all'])
-
-    def test_make_shallow_multi_ref_trim(self):
-        self.add_empty_file('a')
-        self.git('checkout -b a_branch')
-        self.add_empty_file('c')
-        self.git('checkout master')
-        self.assertRevCount(1)
-        self.assertRevCount(2, ['--all'])
-        self.assertRefs(['master', 'a_branch'])
-        self.make_shallow(['-r', 'master', 'HEAD'])
-        self.assertRevCount(1, ['--all'])
-        self.assertRefs(['master'])
-
-    def test_make_shallow_noop(self):
-        self.add_empty_file('a')
-        self.assertRevCount(1)
-        self.make_shallow()
-        self.assertRevCount(1)
-
-    @skipIfNoNetwork()
-    def test_make_shallow_bitbake(self):
-        self.git('remote add origin https://github.com/openembedded/bitbake')
-        self.git('fetch --tags origin')
-        orig_revs = len(self.git('rev-list --all').splitlines())
-        self.make_shallow(['refs/tags/1.10.0'])
-        self.assertRevCount(orig_revs - 1746, ['--all'])
 
 class GitShallowTest(FetcherTest):
     def setUp(self):

-- 
2.43.0


