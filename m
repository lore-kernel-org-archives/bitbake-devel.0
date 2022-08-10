Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABC7C25B06
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 08:45:54 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web09.3519.1660121144595200383
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 01:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QaLj9bQ/;
 spf=pass (domain: gmail.com, ip: 209.85.167.49,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id e15so20365822lfs.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oPOzn+0It9R+uHCBQsr5v981UHCUcAByROZNkHUqGeE=;
        b=QaLj9bQ/e0x7syv2rZoc9A/XdVhPb0KflEwDvTBHXHw1zdbdouuXerVlv/TDAxAIHk
         tghtj2pbOqL6AIFTCBkCGKpnoas/4Up529cZPWym6apaVK4msMF9nGB/4Bl8Io3kzw1t
         eUfWc8B3jrhEiFyFE3pE7ZVH3RxF07NoEXzgUVtxJXtAXEIGEkbTnRnXypcd8VrrRRKH
         8tpKi/SRxy+kVQ1KRJSPrjLEPBnJ98nmNK3Fqw66BSlS1dEG5kDTzIgdjlzx/3zfWAu4
         4rH9f8BTSTdHfVs9NDKE4OA8KV4KvHqvOv6fGyNIlIB/AuHrnmbD2rKpgAinB0aJf6jI
         1keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oPOzn+0It9R+uHCBQsr5v981UHCUcAByROZNkHUqGeE=;
        b=x8225bDufGJ+ahEl6oNuxwjoT0LOIat8zU1JzXXjKDl3mAWsKuThaW81oQhbXs56DS
         nlDsA3Q0S/9Q204whPo7yJrXKoKIdHMGa/1gsggX8NFoobKk/T6WnwTjkuHkkWN/eIUh
         ITt9qd1zNjclVjOoEUklj6+lfb2H+ZHJCjcCVmqNRtJ4CSL/5JM6njOnwVbBu+Aa05Vd
         QPCmTmzDA6YNl5UmQNkUT7mdVZHu65FrJo79VnrROz+g+JftT8GKJwJDDXS026Vd3qHI
         ritdGusL1ox+Ov4XuGGy/PD1+o2w7nnh2N5RvJTUz4jUQ5bxEPqSgwsn1q+cA3fUjNRE
         WLQA==
X-Gm-Message-State: ACgBeo33+B43jCEc1uNFlH4l3/eXMvJNsnA96oNyVowstSQkWwDNy8o/
	fobposuNiC93tkZXUWcmIst4YBR7ixHMNA==
X-Google-Smtp-Source: 
 AA6agR7Ti2LZeQ0q4+EhMRiHBP6P4ZtsTqlMVCA4yRjoluVfkVmz49GE0F3uk3KkbVhK4sDtgHGSsg==
X-Received: by 2002:a05:6512:e99:b0:48b:2ba1:1511 with SMTP id
 bi25-20020a0565120e9900b0048b2ba11511mr9947575lfb.0.1660121142241;
        Wed, 10 Aug 2022 01:45:42 -0700 (PDT)
Received: from localhost.localdomain ([82.180.151.39])
        by smtp.gmail.com with ESMTPSA id
 x1-20020a2e9dc1000000b0025df5f38da8sm317576ljj.119.2022.08.10.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:45:41 -0700 (PDT)
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Mateusz Marciniec <mateuszmar2@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Subject: [PATCH] fetch2/git: Switch branch to correct hash in case of two
 premirrors
Date: Wed, 10 Aug 2022 10:44:01 +0200
Message-Id: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 08:45:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13878

If we use two premirrors and tarball from the first one contains older
commit then after fetching from tmpdir master ref still points to older
commit, so _contains_ref can't find the proper revision on a branch.

Switch master ref to correct hash so _contains ref can find it. It needs
to be done in for loop because we don't know which branch is used for
specific repo in case of multiple repositories.

We need to use two try blocks because both commands might fail and it's
not the reason to break the execution. There are two specific cases I
want to cover. First is when we have multiple git:// entries in SRC_URI
and one uses "master" and second "main". In this code we don't know
which branch is assigned for which repository so we want to add both
branches - so first we need to remove both branches and one might not
exist. We could check if the branch exists and create it only then but
this would break the second case. Now the second case is when for the
first premirror we remove the branch but we can't create it later
because the hash does not exist on the branch since tarball doesn't
contain the newer commits - then for the second premirror the removal of
the branch would fail.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Mateusz Marciniec <mateuszmar2@gmail.com>
Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
---
 lib/bb/fetch2/git.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4534bd758..ea47df3cf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -362,6 +362,16 @@ class Git(FetchMethod):
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
                 fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
                 runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
+                # Switch branch ref to a correct hash
+                for name in ud.names:
+                    try:
+                        runfetchcmd("LANG=C %s branch -d %s" % (ud.basecmd, ud.parm.get('branch', ud.branches[name])), d, workdir=ud.clonedir)
+                    except:
+                        pass
+                    try:
+                        runfetchcmd("LANG=C %s branch %s %s" % (ud.basecmd, ud.parm.get('branch', ud.branches[name]), ud.revisions[name]), d, workdir=ud.clonedir)
+                    except:
+                        pass
         repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
-- 
2.36.1


