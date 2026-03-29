Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30533FC97EA
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34708.1774809263055289428
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=aw5n6bjB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-202603291834206f3f2f54ba00020776-bwshzk@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202603291834206f3f2f54ba00020776
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=127zOZlTVAH4o2b6Tcyx/iixb6dflLDR8X0TSCHCUL4=;
 b=aw5n6bjBIsuEreRKJDwOsusKESP0RFpNedKGc8InvmuE8v5qLP/5pQ6Elh31aR17oiQKIi
 2simpzhSy6b1NHOtjQvI5JQrR38o2ss79jkQbHhEyIKsKmde0Ja4n/FfYHmVQpY5benhHjU+
 q1V5NYHZcOr4IN+U8uIF/jMQXRzjb5DvxV0gjFDEyCqtSLA3cS/ww3h6aMBQVD28wI/Hu5NT
 WJ+1hw3XGOwjwlesZ+luTYV2aA822kH6OAwYy4BEgwbdgf4CnzHIl6zQR6xW26uFuNDaWI+2
 c1LnqkrfK41TTNAjAFEdOnSeH2hYVV2GLlOuOv94jKHFha7H9DarqS6g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 03/14] bitbake-selftest: add GitUnpackUpdateTest
Date: Sun, 29 Mar 2026 20:32:50 +0200
Message-ID: <20260329183332.1996183-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19268

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add a test class that exercises the new unpack_update() code path in the
Git fetcher, ordered from basic building blocks to advanced workflow and
error cases:

  test_unpack_update_full_clone
    Basic update to a newer upstream revision succeeds and the working
    tree reflects the new content.

  test_unpack_update_dldir_remote_setup
    The "dldir" remote pointing to ud.clonedir is created during the
    initial unpack and is present for subsequent update calls.

  test_unpack_update_ff_with_local_changes
    Full workflow: after a normal unpack the "dldir" remote is verified,
    a local commit is added, download() brings updated_rev into the
    clonedir, and unpack_update() fetches from dldir and rebases the
    local commit fast forward on top. The commit graph (HEAD^ ==
    updated_rev) and both file contents are asserted.

  test_unpack_update_already_at_target_revision
    Calling unpack_update() when the checkout is already at SRCREV is
    a no-op: it succeeds and the working tree is left unchanged.

  test_unpack_update_with_untracked_file
    The status check uses --untracked-files=no so untracked files are
    invisible to it; the update succeeds and the untracked file survives
    the rebase unchanged.

  test_unpack_update_with_staged_changes
    Staged (but not committed) changes are detected by
    "git status --untracked-files=no --porcelain" and block the update;
    LocalModificationsError is raised so the caller can fall back to
    backup + re-fetch.

  test_unpack_update_with_modified_tracked_file
    An unstaged modification to a tracked file is detected by
    "git status --untracked-files=no --porcelain" and blocks the
    update; LocalModificationsError is raised.

  test_unpack_update_conflict_raises_rebase_error
    A local commit that conflicts with the incoming upstream change
    raises RebaseError; the repository is left in a clean state with
    no pending rebase (rebase --abort was called).

  test_unpack_update_untracked_file_overwritten_by_upstream
    An untracked file that would be overwritten by an incoming upstream
    commit causes git to refuse the rebase; RebaseError is raised and
    the repository is not left in a mid-rebase state. Two sub-cases
    are covered: a top-level file clash and a clash inside a
    subdirectory (xxx/somefile).

  test_unpack_update_shallow_clone_fails
    Shallow clones do not carry enough history; UnpackError is raised.

  test_unpack_update_stale_dldir_remote
    When the clonedir has been removed after the initial unpack the
    dldir remote no longer resolves; UnpackError is raised so the
    caller can fall back to a full re-fetch.

  test_fetch_unpack_update_toplevel_api
    The public Fetch.unpack_update(root) API (used by callers such as
    bitbake-setup) dispatches correctly end-to-end through to the Git
    fetcher.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/fetch.py | 559 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 559 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7b8297a78..1d018671a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3793,3 +3793,562 @@ class GoModGitTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.opencensus.io/@v/v0.24.0.mod')))
         self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'go.opencensus.io/@v/v0.24.0.mod')),
                          '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1f8a3893b00f1acec96')
+
+
+class GitUnpackUpdateTest(FetcherTest):
+    """Test the unpack_update functionality for git fetcher.
+
+    Intended workflow
+    1. First-time setup:
+       1. download()  - clones the upstream repo into DL_DIR/git2/... (clonedir).
+       2. unpack()    - clones from clonedir into the workspace (S/workdir) and
+                        registers a 'dldir' git remote pointing at
+                        file://DL_DIR/git2/... for later offline use.
+
+    2. Subsequent updates (what unpack_update is designed for):
+       1. The user works in the unpacked source tree.
+       2. Upstream advances - SRCREV changes in the recipe.
+       3. download()        - fetches the new revision into the local clonedir.
+       4. unpack_update()   - instead of wiping the workspace and re-cloning:
+           * fetches the new revision from the local 'dldir' remote
+           * rebases the user's local commits on top of the new SRCREV
+           * raises LocalModificationsError if uncommitted changes block the
+             update, RebaseError if local commits cannot be rebased, or a
+             plain UnpackError for other failures (shallow clone, stale dldir);
+             in all cases the caller (e.g. bitbake-setup) can fall back to
+             backup + re-clone.
+
+    Key design constraints:
+      * unpack_update() never deletes existing data (unlike unpack()).
+      * Only staged/modified tracked files block the update; untracked files and
+        committed local work are handled gracefully.
+      * The 'dldir' remote is intentionally visible to users outside the
+        fetcher (e.g. for manual 'git log dldir/master').
+      * Currently only git is supported.
+    """
+
+    def setUp(self):
+        """Set up a local bare git source repository with two commits on 'master'.
+
+        self.initial_rev  - the first commit (testfile.txt: 'initial content')
+        self.updated_rev  - the second commit (testfile.txt: 'updated content')
+
+        SRCREV is initialised to self.initial_rev so individual tests can
+        advance it to self.updated_rev (or create further commits) as needed.
+        """
+        FetcherTest.setUp(self)
+
+        self.gitdir = os.path.join(self.tempdir, 'gitrepo')
+        self.srcdir = os.path.join(self.tempdir, 'gitsource')
+
+        self.d.setVar('WORKDIR', self.tempdir)
+        self.d.setVar('S', self.gitdir)
+        self.d.delVar('PREMIRRORS')
+        self.d.delVar('MIRRORS')
+
+        # Create a source git repository
+        bb.utils.mkdirhier(self.srcdir)
+        self.git_init(cwd=self.srcdir)
+
+        # Create initial commit
+        with open(os.path.join(self.srcdir, 'testfile.txt'), 'w') as f:
+            f.write('initial content\n')
+        self.git(['add', 'testfile.txt'], cwd=self.srcdir)
+        self.git(['commit', '-m', 'Initial commit'], cwd=self.srcdir)
+        self.initial_rev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
+
+        # Create a second commit
+        with open(os.path.join(self.srcdir, 'testfile.txt'), 'w') as f:
+            f.write('updated content\n')
+        self.git(['add', 'testfile.txt'], cwd=self.srcdir)
+        self.git(['commit', '-m', 'Update commit'], cwd=self.srcdir)
+        self.updated_rev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
+
+        self.d.setVar('SRCREV', self.initial_rev)
+        self.d.setVar('SRC_URI', 'git://%s;branch=master;protocol=file' % self.srcdir)
+
+    def test_unpack_update_full_clone(self):
+        """Test that unpack_update updates an existing checkout in place for a full clone.
+
+        Steps:
+        1. Fetch and unpack at self.initial_rev - verify 'initial content'.
+        2. Advance SRCREV to self.updated_rev and re-download.
+        3. Call unpack_update() instead of unpack() - the existing checkout
+           must be updated via 'git fetch dldir' + 'git rebase' without
+           re-cloning the directory.
+        4. Verify testfile.txt now contains 'updated content'.
+        """
+        # First fetch at initial revision
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        # Verify initial state
+        unpack_path = os.path.join(self.unpackdir, 'git')
+        self.assertTrue(os.path.exists(os.path.join(unpack_path, 'testfile.txt')))
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'r') as f:
+            self.assertEqual(f.read(), 'initial content\n')
+
+        # Update to new revision
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        # Use unpack_update
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+        git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+        # Verify updated state
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'r') as f:
+            self.assertEqual(f.read(), 'updated content\n')
+
+    def test_unpack_update_dldir_remote_setup(self):
+        """Test that unpack() adds a 'dldir' git remote pointing at ud.clonedir.
+
+        The 'dldir' remote is used by subsequent unpack_update() calls to fetch
+        new commits from the local download cache (${DL_DIR}/git2/…) without
+        requiring network access. After a normal unpack the remote must exist
+        and its URL must be 'file://<ud.clonedir>'.
+        """
+        # First fetch
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Check that dldir remote exists
+        remotes = self.git(['remote'], cwd=unpack_path).strip().split('\n')
+        self.assertIn('dldir', remotes)
+
+        # Verify it points to the clonedir
+        dldir_url = self.git(['remote', 'get-url', 'dldir'], cwd=unpack_path).strip()
+        self.assertEqual(dldir_url, 'file://{}'.format(ud.clonedir))
+
+    def test_unpack_update_ff_with_local_changes(self):
+        """Test that unpack_update rebases local commits fast forward.
+
+        Full workflow:
+        1. Fetch + unpack at initial_rev - verify 'dldir' remote is created
+           pointing at ud.clonedir.
+        2. Add a local commit touching localfile.txt.
+        3. Advance SRCREV to updated_rev and call download() - verify that
+           ud.clonedir (the dldir bare clone) now contains updated_rev.
+        4. Call unpack_update() - it fetches updated_rev from dldir into the
+           working tree and rebases the local commit on top.
+        5. Verify the final commit graph: HEAD's parent is updated_rev, and
+           both testfile.txt ('updated content') and localfile.txt ('local
+           change') are present.
+
+        Note: git rebase operates the same way regardless of whether HEAD is
+        detached or on a named branch (e.g. 'master' or a local feature branch),
+        so this test covers those scenarios implicitly.
+        """
+        # Step 1 - fetch + unpack at initial_rev
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # The normal unpack must have set up the 'dldir' remote pointing at
+        # ud.clonedir so that subsequent unpack_update() calls work offline.
+        dldir_url = self.git(['remote', 'get-url', 'dldir'], cwd=unpack_path).strip()
+        self.assertEqual(dldir_url, 'file://{}'.format(ud.clonedir))
+
+        # Step 2 - add a local commit that touches a new file
+        with open(os.path.join(unpack_path, 'localfile.txt'), 'w') as f:
+            f.write('local change\n')
+        self.git(['add', 'localfile.txt'], cwd=unpack_path)
+        self.git(['commit', '-m', 'Local commit'], cwd=unpack_path)
+        local_commit = self.git(['rev-parse', 'HEAD'], cwd=unpack_path).strip()
+
+        # Step 3 - advance SRCREV and download; clonedir must now contain
+        # updated_rev so that unpack_update can fetch it without network access.
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        ud = fetcher.ud[uri]
+        clonedir_refs = self.git(['rev-parse', self.updated_rev], cwd=ud.clonedir).strip()
+        self.assertEqual(clonedir_refs, self.updated_rev,
+                         "clonedir must contain updated_rev after download()")
+
+        # Step 4 - unpack_update fetches from dldir and rebases
+        git_fetcher = ud.method
+        git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+        # Step 5 - verify the commit graph and working tree content
+        # HEAD is the rebased local commit; its parent must be updated_rev
+        head_rev = self.git(['rev-parse', 'HEAD'], cwd=unpack_path).strip()
+        parent_rev = self.git(['rev-parse', 'HEAD^'], cwd=unpack_path).strip()
+        self.assertNotEqual(head_rev, local_commit,
+                            "local commit should have a new SHA after rebase")
+        self.assertEqual(parent_rev, self.updated_rev,
+                         "HEAD's parent must be updated_rev after fast-forward rebase")
+
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'r') as f:
+            self.assertEqual(f.read(), 'updated content\n')
+        with open(os.path.join(unpack_path, 'localfile.txt'), 'r') as f:
+            self.assertEqual(f.read(), 'local change\n')
+
+    def test_unpack_update_already_at_target_revision(self):
+        """Test that unpack_update is a no-op when the checkout is already at SRCREV.
+
+        Calling unpack_update() without advancing SRCREV must succeed and leave
+        the working tree unchanged. No rebase should be attempted because the
+        checkout already points at ud.revision.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+        with open(os.path.join(unpack_path, 'testfile.txt')) as f:
+            self.assertEqual(f.read(), 'initial content\n')
+
+        # Call unpack_update with SRCREV still at initial_rev - no upstream change
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+        result = git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+        self.assertTrue(result)
+
+        # Content must be unchanged
+        with open(os.path.join(unpack_path, 'testfile.txt')) as f:
+            self.assertEqual(f.read(), 'initial content\n')
+
+    def test_unpack_update_with_untracked_file(self):
+        """Test that unpack_update succeeds when the checkout has an untracked file.
+
+        The status check uses '--untracked-files=no', so untracked files are not
+        detected and do not trigger the fallback path. git rebase also leaves
+        untracked files untouched, so both the upstream update and the untracked
+        file must be present after the call.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Create an untracked file (not staged, not committed)
+        untracked = os.path.join(unpack_path, 'untracked.txt')
+        with open(untracked, 'w') as f:
+            f.write('untracked content\n')
+
+        # Update to new upstream revision
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+
+        # --untracked-files=no means the status check passes; rebase preserves the file
+        git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'r') as f:
+            self.assertEqual(f.read(), 'updated content\n')
+
+        # Untracked file must survive the rebase
+        self.assertTrue(os.path.exists(untracked))
+        with open(untracked, 'r') as f:
+            self.assertEqual(f.read(), 'untracked content\n')
+
+    def test_unpack_update_with_staged_changes(self):
+        """Test that unpack_update fails when the checkout has staged (but not committed) changes.
+
+        The rebase is run with --no-autostash so git refuses to rebase over a
+        dirty index. The caller (bitbake-setup) is expected to catch the
+        resulting LocalModificationsError and fall back to backup + re-fetch.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Stage a new file without committing it
+        staged = os.path.join(unpack_path, 'staged.txt')
+        with open(staged, 'w') as f:
+            f.write('staged content\n')
+        self.git(['add', 'staged.txt'], cwd=unpack_path)
+
+        # Update to new upstream revision
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+
+        # Should fail - git rebase refuses to run with a dirty index
+        with self.assertRaises(bb.fetch2.LocalModificationsError):
+            git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+    def test_unpack_update_with_modified_tracked_file(self):
+        """Test that unpack_update fails when a tracked file has unstaged modifications.
+
+        'git status --untracked-files=no --porcelain' reports unstaged modifications
+        to tracked files (output line ' M filename'), which must block the update so
+        the caller can fall back to backup + re-fetch rather than silently discarding
+        work in progress.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Modify a tracked file without staging or committing
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'w') as f:
+            f.write('locally modified content\n')
+
+        # Update to new upstream revision
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+
+        # Should fail - unstaged modification to tracked file is detected by
+        # 'git status --untracked-files=no --porcelain'
+        with self.assertRaises(bb.fetch2.LocalModificationsError):
+            git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+    def test_unpack_update_conflict_raises_rebase_error(self):
+        """Test that unpack_update raises RebaseError on a rebase conflict.
+
+        When a local commit modifies the same lines as an incoming upstream commit,
+        git rebase cannot resolve the conflict automatically. unpack_update must
+        abort the failed rebase and raise RebaseError so the caller can fall back
+        to a backup + re-fetch.
+        """
+        # Fetch and unpack at the initial revision
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Make a local commit that edits the same lines as the upcoming upstream commit
+        with open(os.path.join(unpack_path, 'testfile.txt'), 'w') as f:
+            f.write('conflicting local content\n')
+        self.git(['add', 'testfile.txt'], cwd=unpack_path)
+        self.git(['commit', '-m', 'Local conflicting commit'], cwd=unpack_path)
+
+        # Add a third upstream commit that also edits testfile.txt differently
+        with open(os.path.join(self.srcdir, 'testfile.txt'), 'w') as f:
+            f.write('conflicting upstream content\n')
+        self.git(['add', 'testfile.txt'], cwd=self.srcdir)
+        self.git(['commit', '-m', 'Upstream conflicting commit'], cwd=self.srcdir)
+        conflict_rev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
+
+        # Update SRCREV to the new upstream commit
+        self.d.setVar('SRCREV', conflict_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+
+        # unpack_update must fail and clean up (rebase --abort) rather than
+        # leaving the repo in a mid-rebase state
+        with self.assertRaises(bb.fetch2.RebaseError):
+            git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+        # Verify the repo is not left in a conflicted / mid-rebase state
+        rebase_merge = os.path.join(unpack_path, '.git', 'rebase-merge')
+        rebase_apply = os.path.join(unpack_path, '.git', 'rebase-apply')
+        self.assertFalse(os.path.exists(rebase_merge),
+                         "rebase-merge dir should not exist after failed unpack_update")
+        self.assertFalse(os.path.exists(rebase_apply),
+                         "rebase-apply dir should not exist after failed unpack_update")
+
+    def test_unpack_update_untracked_file_overwritten_by_upstream(self):
+        """Test that unpack_update raises RebaseError when an untracked file would be
+        overwritten by an incoming upstream commit.
+
+        We skip untracked files in the pre-check (git rebase doesn't touch harmless
+        untracked files), but git itself refuses to rebase when an untracked file would
+        be overwritten by the incoming changes. The resulting FetchError must be caught
+        and re-raised as RebaseError without leaving the repo in a mid-rebase state.
+
+        Two sub-cases are covered:
+        - top-level untracked file clashing with an incoming upstream file
+        - untracked file inside a subdirectory (xxx/somefile) clashing with an
+          upstream commit that adds the same path
+        """
+        def _run_case(upstream_path, local_rel_path, commit_msg):
+            """
+            Add upstream_path to self.srcdir, create local_rel_path as an
+            untracked file in the checkout, then assert that unpack_update
+            raises RebaseError and leaves no mid-rebase state, and that the
+            local file is untouched.
+            """
+            # Fresh fetch + unpack at the current SRCREV
+            fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+            fetcher.download()
+            fetcher.unpack(self.unpackdir)
+
+            unpack_path = os.path.join(self.unpackdir, 'git')
+
+            # Upstream adds the file (potentially inside a subdirectory)
+            full_upstream = os.path.join(self.srcdir, upstream_path)
+            os.makedirs(os.path.dirname(full_upstream), exist_ok=True)
+            with open(full_upstream, 'w') as f:
+                f.write('upstream content\n')
+            self.git(['add', upstream_path], cwd=self.srcdir)
+            self.git(['commit', '-m', commit_msg], cwd=self.srcdir)
+            new_rev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
+
+            # Create the clashing untracked file in the checkout
+            full_local = os.path.join(unpack_path, local_rel_path)
+            os.makedirs(os.path.dirname(full_local), exist_ok=True)
+            with open(full_local, 'w') as f:
+                f.write('local untracked content\n')
+
+            self.d.setVar('SRCREV', new_rev)
+            fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+            fetcher.download()
+
+            uri = self.d.getVar('SRC_URI')
+            ud = fetcher.ud[uri]
+            git_fetcher = ud.method
+
+            # git rebase refuses because the untracked file would be overwritten
+            with self.assertRaises(bb.fetch2.RebaseError):
+                git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+            # Repo must not be left in a mid-rebase state
+            self.assertFalse(os.path.exists(os.path.join(unpack_path, '.git', 'rebase-merge')))
+            self.assertFalse(os.path.exists(os.path.join(unpack_path, '.git', 'rebase-apply')))
+
+            # The local untracked file must be untouched
+            self.assertTrue(os.path.exists(full_local))
+            with open(full_local) as f:
+                self.assertEqual(f.read(), 'local untracked content\n')
+
+            # Reset unpackdir for the next sub-case
+            import shutil as _shutil
+            _shutil.rmtree(self.unpackdir)
+            os.makedirs(self.unpackdir)
+
+        # Sub-case 1: top-level file clash
+        _run_case('newfile.txt', 'newfile.txt',
+                  'Upstream adds newfile.txt')
+
+        # Sub-case 2: file inside a subdirectory (xxx/somefile)
+        _run_case('xxx/somefile.txt', 'xxx/somefile.txt',
+                  'Upstream adds xxx/somefile.txt')
+
+    def test_unpack_update_shallow_clone_fails(self):
+        """Test that unpack_update raises UnpackError for shallow-tarball checkouts.
+
+        Shallow clones lack full history, which makes an in-place rebase impossible
+        without network access. After fetching with BB_GIT_SHALLOW=1 the clonedir
+        is deleted so that unpack() is forced to use the shallow tarball.
+        A subsequent call to unpack_update() must raise UnpackError and the message
+        must mention 'shallow clone' so callers can distinguish this case.
+        """
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
+
+        # First fetch at initial revision
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        # Remove clonedir to force use of shallow tarball
+        clonedir = os.path.join(self.dldir, 'git2')
+        if os.path.exists(clonedir):
+            shutil.rmtree(clonedir)
+
+        fetcher.unpack(self.unpackdir)
+
+        # Update to new revision
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        # unpack_update should fail for shallow clones
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+        git_fetcher = ud.method
+
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+        self.assertIn("shallow clone", str(context.exception).lower())
+
+    def test_unpack_update_stale_dldir_remote(self):
+        """Test that unpack_update raises UnpackError when the dldir remote URL is stale.
+
+        If the clonedir has been removed after the initial unpack (e.g. DL_DIR was
+        cleaned) the 'dldir' remote URL no longer resolves. The fetch inside
+        update_mode will fail with a FetchError which must be re-raised as
+        UnpackError so the caller can fall back to a full re-fetch.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+
+        # Advance SRCREV to trigger update_mode
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        uri = self.d.getVar('SRC_URI')
+        ud = fetcher.ud[uri]
+
+        # Delete the clonedir and corrupt the dldir remote URL so that
+        # 'git fetch dldir' fails, simulating a missing or relocated DL_DIR.
+        shutil.rmtree(ud.clonedir)
+        self.git(['remote', 'set-url', 'dldir', 'file://' + ud.clonedir],
+                 cwd=unpack_path)
+
+        git_fetcher = ud.method
+        with self.assertRaises(bb.fetch2.UnpackError):
+            git_fetcher.unpack_update(ud, self.unpackdir, self.d)
+
+    def test_fetch_unpack_update_toplevel_api(self):
+        """Test that the top-level Fetch.unpack_update() dispatches to Git.unpack_update().
+
+        Callers such as bitbake-setup use fetcher.unpack_update(root) rather than
+        calling the method on the Git fetcher directly. Verify that the public API
+        works end-to-end: fetch at initial_rev, unpack, advance to updated_rev,
+        fetch again, then call fetcher.unpack_update(root) and confirm the content
+        is updated.
+        """
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        unpack_path = os.path.join(self.unpackdir, 'git')
+        with open(os.path.join(unpack_path, 'testfile.txt')) as f:
+            self.assertEqual(f.read(), 'initial content\n')
+
+        self.d.setVar('SRCREV', self.updated_rev)
+        fetcher = bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher.download()
+
+        # Use the public Fetch.unpack_update() rather than the method directly
+        fetcher.unpack_update(self.unpackdir)
+
+        with open(os.path.join(unpack_path, 'testfile.txt')) as f:
+            self.assertEqual(f.read(), 'updated content\n')
-- 
2.53.0


