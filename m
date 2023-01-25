Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF0C54E94
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 12:34:56 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.44042.1674650093469884915
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jan 2023 04:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mYYDP6JF;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: ptsneves@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id x10so21622119edd.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcY5B5kAwJT+dZTAA8MPKpxs/JBSUazPrtvIoWLHiZ4=;
        b=mYYDP6JFEIHEk5ZNCHyzgsaWSmiaqZL8QSpEiIbQfoJH1zrV1b3cilXQjI7wht6qvg
         TjcdExHlbZJXXCjYWdpaG29Wmqz4xAmtj7fNXow9DvycPzyX4YPpTiG/1dN5sLH3Cd/o
         rp4Wrd0J7XB54aDjFFms3NHH+vjZxpu0J6g7cPAsDRaTS7quJ5lcY4kWvsC7d5vNP7zb
         q6DVzYY7em+60S2awc/RtBBC1blOy8LUMDYtXb6CICaJ10loJYhzIBLUP3MludnniWcv
         uThxWzi7JFD6BkURVXsDjMNawzop2L664bvNGDH6gsmv3CtPKYgIN7bhowELjwB1pktw
         G7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcY5B5kAwJT+dZTAA8MPKpxs/JBSUazPrtvIoWLHiZ4=;
        b=S81qV8oV7XMQkDEAFsQQyoJ/lfMyQ+vlJDDyeQvuMQPgMDZL5dgDNJwBCXeHvjjfds
         qXUNKxbQaVE5BPh3PoTcFKN4vYBrLTHFXtlHKXvrE6c78FPTZbvAzqDlCFLiditTSEsU
         a6sDoIOY9yfPB/kxbSUKmkat22RCs0bJDjff0mLLKaf64CfcYmLh3chPNYKlOESnIEKf
         /RjPt/ByRRdCj8bIoKZNkFMmGsbtzXmQBxZEA1uYkZprAWpMA4DG5t9Abqrh4ReVcHFH
         jiAhsfYNmkurOyiXOX9XYdxLbWE9/ykq3F24F5MJgaktHy+yYyxvJlV0sQOb1B+INPCn
         XGZQ==
X-Gm-Message-State: AFqh2kpnAevjAUoH5BPeX3MYF87C8ILa/G/ycKZhrpqRaFTDTr4H32x9
	R3LxJIW+uFBYM2Kt019X/BJtNJAbPA==
X-Google-Smtp-Source: AMrXdXt7rxzwWr0Bx03ho8an3NFFrTh7Bc/88S2tv449Kp+ZHRGo17SLdox5aW8i5W4bbJmc9KYhfQ==
X-Received: by 2002:a05:6402:5306:b0:49b:b274:b815 with SMTP id eo6-20020a056402530600b0049bb274b815mr35569066edb.39.1674650091747;
        Wed, 25 Jan 2023 04:34:51 -0800 (PST)
Received: from localhost.localdomain (031011128019.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.19])
        by smtp.gmail.com with ESMTPSA id t21-20020a056402021500b00488abbbadb3sm2276131edv.63.2023.01.25.04.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 04:34:51 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH 1/1] bitbake-getvar: Add a quiet command line argument
Date: Wed, 25 Jan 2023 13:34:46 +0100
Message-Id: <20230125123446.327354-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 12:34:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14340

bitbake-getvar does not have a way to silence bitbake
server's logger and that makes the tool hard to use for
text processing. This is especially true when one wants to
get a bitbake value to be piped to some other utility and
instead we get uncontrolled logging messages or warnings
together with bitbake's variable value.

Example without quiet:
bitbake-getvar --value MACHINE
NOTE: Starting bitbake server...
qemux86-64

With quiet:
bitbake-getvar --value MACHINE --quiet
qemux86-64

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 bin/bitbake-getvar | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 5435a8d79..4a9eb4f31 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -25,6 +25,7 @@ if __name__ == "__main__":
     parser.add_argument('-u', '--unexpand', help='Do not expand the value (with --value)', action="store_true")
     parser.add_argument('-f', '--flag', help='Specify a variable flag to query (with --value)', default=None)
     parser.add_argument('--value', help='Only report the value, no history and no variable name', action="store_true")
+    parser.add_argument('-q', '--quiet', help='Silence bitbake server logging', action="store_true")
     args = parser.parse_args()
 
     if args.unexpand and not args.value:
@@ -35,7 +36,7 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True) as tinfoil:
+    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=2)
             d = tinfoil.parse_recipe(args.recipe)
-- 
2.34.1


