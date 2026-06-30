Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429CC43602
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 14:23:25 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13353.1782788323253025489
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 19:58:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=q4oWArHV;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: dchvs11@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c126b8118afso223324666b.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 19:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782788321; cv=none;
        d=google.com; s=arc-20260327;
        b=lJn/8588ntgxoacPf1JAab73ltr3PDTHX+T1GW3RiwLJ6QL/hzWv/KJdLrI+AyNCNm
         8zz4eQDz/NbBGns77oVphVGLrTyyFUR47hXVNLW2cXgtpgj5ZzzzReyPbrfVD9921gjn
         P7AVhlxh0a07vJRTXJniMmU3DTOJ3HLN6HlSfiuCxlEjrAr8qR38fRRbFfKovJenJ9jL
         EYSc/egU+RJObOosDDLGxvM+qu8hQLV3gHF66svwBakk1se54a15MKH3i9cdbJ+unYob
         ko55XFe7tK09Cavvkiua/js4H23zrmpBNnI1cM4Gg8R2gaWM6fIZfeDkpSbxlDn+mHtu
         fdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eveqaQ81BC1wcdCKsIemx2Nfa5FTyNjibtGpz1y1TVg=;
        fh=xlJr4eUX1DlAYk6Ppr40xqLOKfw5/svXuQb7Bs4sV88=;
        b=SiJcCBerPzUqEwHi27TrcJ9zW9tlRfLnbVNb8XcpcPO+YhRKwiOuOzH4/cZRwYjA6y
         J7I2lSfD+l1u+f3zQBlbtCQXog0/3aQz1b7rAWkP7fQmDVQWSr1e1NZ5BVzwO62qgqsx
         G49px90g/dgvLZR3wmkLTG692JGuh5D3hZExQ3hAqIEyvxqM3JL7VpzdQ5FCLKsBIesl
         gxeM2qHMVBAyGyHJ0FNFTzljWfumoxzXfN7KS/zQQ5Sx32aWghRLLckQPaDUDzCR2k2m
         v1IfIt+UhevnaWQclHwY2jSHGUtBC4ikrX1KCCZ8TGoAjx8JzcQuDgxtQwuvvjMraJjO
         1ZXA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782788321; x=1783393121; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eveqaQ81BC1wcdCKsIemx2Nfa5FTyNjibtGpz1y1TVg=;
        b=q4oWArHV4HdXHn+Rdh4KEaDXWX3K8Qui+RcBBYPoMcYSgy6sOAhwy/VVwVdmx7R5Ru
         bbsz0RFF4n/9Ohjm7bGKh392I4aD97v7WCVDQnQx4k8/7HZ/8d3ZDr2U6DSI1+6M6bPs
         RLZzutIvpBlgrNtqVx6lMlrMmw49CjAj/pxfhzmL96gQ1ZTxpG1o/Oo9+Fw5yqYfmgFU
         C2ItFY3uhmNvqQiDBXHonL8zTFQs67FxBmhENqnY5XMfKBzIVZIgsotKXjwAsH8ZUMFY
         yGt+ZdJTd4Za5mzK8djU+w0Vh/D2FvS9olnhnVmmB2yE9Fsr1TvwyKmAKE0Ox/T6Qivu
         68Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782788321; x=1783393121;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eveqaQ81BC1wcdCKsIemx2Nfa5FTyNjibtGpz1y1TVg=;
        b=OwYOVJKAX+KggaHG0tNy2pSBlRMNiDQRWx6aMJCjQmaCPqBVCFG0dH8yikRk5uPiuo
         Hg0IeFdkJiPqBxp4i9czqS7lQGirAXvmhfd5Y8ULZWjeBN/GWPBUPYAsGitGf35Tuzhf
         Brc20TdrSPdu+aojQHTSrbmuZRHQ3UpzluYjT22Y5gK0iT490Ek7a2iWtS0gg8ywJqgs
         ou8TlTTCvQ63qCb9IIbXWiumWZ7zJBX0JHTTJgVMIa0LiL18sAO1AADpLt7/lPIyHqLG
         JFzj0iCrecGD8L8Ny3ZN61VZeAXUsnW4r/THhZ7k03HJPIb0urf1/ilLzczVjdDLQ964
         gASQ==
X-Gm-Message-State: AOJu0YyLtgafRBL+K+46ZGHmG/Q+oD1T7FRqT/KSHj3KjBDelnnsf7me
	fojqas/rtA8uBdcjJVLG9DQSvDMvMncYha+UcKrNlxia7Hto0FKTrCIfoSvp4P8XA9ZqLfjXx7W
	UvY3wJ314G1JP3UZZ9UUdwf+C6PO1gZdNuPWTq60=
X-Gm-Gg: AfdE7cm+kUy4ZXFb5cfkqkyOu0O04RXQ3IG0DeHLZYW6HW0BTpwL7aBkEiZ81wKRQwo
	0iAblvGK9PPJlcGr88MP3K/sKzOgDQtGKP6kKVkvrmDauKHyPDghDuQgTJoFMwDg0zxjlmASXiv
	ZqkHQvpQReo17QqKsgH1xPaz54OBXtYB/Dn7zEgv3KTH5m8jT950VpzAd5BWvEzNsRpA+h9FqUa
	hFjfr50jDmWCGqhKQdoMZcjIngydGWB7CJBmNXB8U/xgokdCWBstHcLkn5qRu2Glzip6cbIT/g=
X-Received: by 2002:a17:907:1b15:b0:c12:4c5b:f170 with SMTP id
 a640c23a62f3a-c1287444ea3mr69933566b.62.1782788320972; Mon, 29 Jun 2026
 19:58:40 -0700 (PDT)
MIME-Version: 1.0
From: "Daniel" <dchvs11@gmail.com>
Date: Mon, 29 Jun 2026 20:58:28 -0600
X-Gm-Features: AVVi8CcoIAifz0F8VA7Zjuvl3JeOigUM8gt_-LR00xSBCnI64g62-kYpMrj5p_M
Message-ID: <CANDCFSwD88aPfsKDqZE_SdybCn5xYBF1VpRqgwmhTEuJK=eLcQ@mail.gmail.com>
Subject: [PATCH] bitbake-setup: support --update-bb-conf on init and fix site.conf symlink for setup-dir == top-dir
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jul 2026 14:23:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19814

  Two fixes that work together to let "bitbake-setup init" preserve an
  existing bitbake build configuration (local.conf, bblayers.conf):

  1. Expose the existing update_bb_conf parameter through a new
     --update-bb-conf CLI flag on init, matching the semantics of
     "bitbake-setup update". This lets downstream projects re-run init
     (e.g. to refresh layers via --source-overrides) without losing
     their tracked conf files. The default remains "yes" for backward
     compatibility, so a fresh init is unaffected.

  2. Fix the site.conf symlink target when the setup directory is the
     same as the top directory. The target was always computed as
     setupdir/../site.conf, which only matches the actual site.conf
     location (top_dir/site.conf) when the setup directory is exactly
     one level below the top directory. When --setup-dir-name is given
     an absolute path equal to the top directory, the symlink ends up
     broken, which causes "diff -uNr" to fail with exit code 2 inside
     setup_bitbake_build(). That exception is raised before the
     update_bb_conf == 'no' branch can restore the original conf,
     defeating the new flag from #1. Prefer setupdir/site.conf when it
     exists, falling back to the previous behaviour otherwise.

  Together these changes make "bitbake-setup init --update-bb-conf=no"
  behave like Yocto's oe-init-build-env: the build environment is
  preserved across re-initializations.

  Signed-off-by: Daniel Chaves <dchvs11@gmail.com>
  ---
   bin/bitbake-setup | 9 +++++++--
   1 file changed, 7 insertions(+), 2 deletions(-)

  diff --git a/bin/bitbake-setup b/bin/bitbake-setup
  index 97ea08d..9a59a5a 100755
  --- a/bin/bitbake-setup
  +++ b/bin/bitbake-setup
  @@ -371,7 +371,10 @@ def setup_bitbake_build(bitbake_config,
layerdir, setupdir, thisdir, update_bb_c
       _prepend_passthrough_to_init_build_env(bitbake_builddir)

       siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
  -    siteconf = os.path.normpath(os.path.join(setupdir, '..', "site.conf"))
  +    if os.path.exists(os.path.join(setupdir, "site.conf")):
  +        siteconf = os.path.join(setupdir, "site.conf")
  +    else:
  +        siteconf = os.path.normpath(os.path.join(setupdir, '..',
"site.conf"))
       if os.path.lexists(siteconf_symlink):
           os.remove(siteconf_symlink)
       os.symlink(os.path.relpath(siteconf, bitbake_confdir), siteconf_symlink)
  @@ -870,7 +873,7 @@ def init_config(top_dir, settings, args):
       bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)

       write_upstream_config(confdir, upstream_config)
  -    update_build(upstream_config, confdir, setupdir, layerdir, d,
update_bb_conf="yes", init_vscode=args.init_vscode)
  +    update_build(upstream_config, confdir, setupdir, layerdir, d,
update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode)

       bb.event.remove("bb.build.TaskProgress", None)

  @@ -1268,6 +1271,8 @@ def main():
                           help='Symlink local source into a build,
instead of getting it as prescribed by a configuration (useful for
local development).')
       parser_init.add_argument('--init-vscode',
action=argparse.BooleanOptionalAction,
default=bool(shutil.which('code')),
                           help='Generate VSCode workspace
configuration (default: %(default)s)')
  +    parser_init.add_argument('--update-bb-conf', choices=['prompt',
'yes', 'no'], default='yes',
  +                        help='Update bitbake configuration files
(bblayers.conf, local.conf) when re-initializing an existing setup
(default: %(default)s)')
       parser_init.set_defaults(func=init_config)

       parser_status = subparsers.add_parser('status', help='Check if
the setup needs to be synchronized with configuration')

