Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web09.32536.1607939109723550475
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Dec 2020 01:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=YLcMkBUr;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: jdegges@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id q22so11726127pfk.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Dec 2020 01:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoSJGUnmNRDbTNBNGpjw9cIo2kHYMBeGjXt1ZLPFgus=;
        b=YLcMkBUrD+toVlh7rRh9ffkPrvlHS3L6hZKIck5ZcL4Q2Tfj9GsnOy0plXoqcuDu17
         bORz8IxbB+Bfv6ua3UikWJ+cr3GnVn26PesgikpBZa1D6lhHOsVj1eiUA22VyAGb+L9c
         oa7gAbAYJRztscm/zJlNI2QX4Z4pNmrwf/8+CDJzrXTct26iQ5Zh6zAmVGRu2wX4T2UI
         gyRnH3nYLFoFPj5i1rQPnqBwvc/t/CWCI+h0P7kbEb8JtedeeEYTi8pu7Bwo3vBJ4CQ5
         pTK3Upyv90dSIATjWBQKsQE1zNdW0iGP5V5vjp772r/o8Fe81mKxy9N/HehlItri6lFn
         SxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoSJGUnmNRDbTNBNGpjw9cIo2kHYMBeGjXt1ZLPFgus=;
        b=TASLYNo6UonAv8khJAU0zrWe0t6BGXcLhWe/a3zbT86pg/cOWy44rQFamIXaJpo6kV
         q54AFOJLHD5/WOWBAW/9OeL/FeM9k54imCBlURG4Jnvrxn/b2UUmkGhmSPuTIl/3VKSl
         Zdw3xj3zUuAt8KNnHNOC1oxynyJMSn7xvscIl8je8KZhPAGS1bAkeYiozRKR0IXaNM6Q
         HDI/bhzFvDSp0bjf128nmL/f9kd3KnXAAWgISRqGVeTbG/Hc55RjwrhG/qHtNwgc/7g/
         TQP8BdfmgCWrPClUqcnXuKYl1Q+ih28/CCgljNzLfwVAl0WXZ6miwmnbXUDnO1F1yBX5
         C2vA==
X-Gm-Message-State: AOAM531Nl/lYbs6VFi3CQ5rf+yXE0dQsbGz3rdhaLIYue0hz80Fm7WRF
	nHuZfO7Lwq+9hdVSu3MmIMHKg+pnuey/eg==
X-Google-Smtp-Source: ABdhPJy+lMKlF23B1GxsTSkmIim24Y558ZtNTSw28kegihWJzvpzpYod9QgpstbzSMJPANy7iuEriw==
X-Received: by 2002:a63:5f12:: with SMTP id t18mr14231128pgb.308.1607939108836;
        Mon, 14 Dec 2020 01:45:08 -0800 (PST)
Return-Path: <jdegges@gmail.com>
Received: from localhost.localdomain (c-73-231-35-50.hsd1.ca.comcast.net. [73.231.35.50])
        by smtp.gmail.com with ESMTPSA id g5sm19444245pfr.87.2020.12.14.01.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 01:45:08 -0800 (PST)
From: jdegges@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Joey Degges <jdegges@gmail.com>
Subject: [PATCH] bitbake: fetch/git: Fix usehead for non-default names
Date: Mon, 14 Dec 2020 01:44:59 -0800
Message-Id: <20201214094459.15545-1-jdegges@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usehead url parameter for git repositories causes bitbake to use
whatever commit the repository HEAD is pointing to if the repository
happens to have the name 'default'. This is the default name so in many
cases it works just fine, but if a different name is specified with the
url parameter 'name=newName' then it will fail to parse the recipe with
an error along the lines of:

ERROR: ExpansionError during parsing /path/to/my/recipe.bb
Traceback (most recent call last):
  File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 235, in Git.urldata_init:
    >        ud.setup_revisions(d)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1302, in FetchData.setup_revisions:
             for name in self.names:
    >            self.revisions[name] = srcrev_internal_helper(self, d, name)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1167, in srcrev_internal_helper(name='newName'):
         if srcrev == "AUTOINC":
    >        srcrev = ud.method.latest_revision(ud, d, name)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1562, in Git.latest_revision(name='newName'):
             except KeyError:
    >            revs[key] = rev = self._latest_revision(ud, d, name)
                 return rev
  File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 650, in Git._latest_revision(name='newName'):
             raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
    >            (ud.unresolvedrev[name], ud.host+ud.path))
bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Unable to resolve 'master' in upstream git repository in git ls-remote output for /path/to/local/git/repo

Let's fix this by setting the unresolved rev of _all_ repository names
to 'HEAD' when the usehead url parameter is specified.

This change preserves existing behavior that allows usehead to be
overridden by a valid looking revision if one happens to be specified
instead of AUTOREV.

Signed-off-by: Joey Degges <jdegges@gmail.com>
---
 lib/bb/fetch2/git.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 490d57fb..df9538a6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -220,7 +220,12 @@ class Git(FetchMethod):
             ud.shallow = False
 
         if ud.usehead:
-            ud.unresolvedrev['default'] = 'HEAD'
+            # When usehead is set let's associate 'HEAD' with the unresolved
+            # rev of this repository. This will get resolved into a revision
+            # later. If an actual revision happens to have also been provided
+            # then this setting will be overridden.
+            for name in ud.names:
+                ud.unresolvedrev[name] = 'HEAD'
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
 
-- 
2.24.3 (Apple Git-128)

