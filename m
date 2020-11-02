Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.30122.1604317865377358560
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 03:51:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W0EdiaUg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id i16so8822372wrv.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2020 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UJIk6ituVqUwbljH0sLIppQQBalA794nHDMLUqwK/w=;
        b=W0EdiaUgwXsrr9dmg8Eo/SshIhBxWyApNOBDj4vz2tuCy+dvzniacYGyJOKBIy4IjU
         HV+d3m14xEXhvF/HfmM2NK8nLvbttRfyw/uhAKMQaCRUMCHK6Tt06FvLkPwiR6cLdzdR
         c1ylO+IWxCDChPJ7dtXXEYSh6l5ebNkTF6N7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UJIk6ituVqUwbljH0sLIppQQBalA794nHDMLUqwK/w=;
        b=FBjDl8NEAlLWLie3GFfQNQNDeZK6AdjfI+GAKsjRwyFeRBZguFNxC0x/O/mO1sAFAi
         HogM/mtGNsSU2XwFNoEnr5e5es8KbD39XPKUq7/DVeHWgbjkj2n7AH92+DUk+CvF5HoM
         YN6DwBQ5VZ5HFhdK+j5zevB6ksxz+u/L6gUndnz6rOFRig1cqG/pkTBS3vX03fG2BxSK
         FbBNu1DC9gUROvZTHudmbsp0bvAkiym2BJL6xhCw9BlecGkl3vOIQG1cdO8aGbfBrD2v
         zLY2dYtz+hnISgQLzHeDrYEI0oBJj0rvgC8vtClvM17rB/II319ONpkKd749K7QulUPH
         yslg==
X-Gm-Message-State: AOAM533Ts6vnkdOX8MyWf/iTCIDQ3n2osnd0GHJXEyayyhJ5frBO4x2k
	dpNcSwHWtZ1xqIlhmaBxdm6qTEz+3xMiDw==
X-Google-Smtp-Source: ABdhPJw8iVnfDtb3KIzhGW0lqn2oJaUR7LR+xv/emRicFbUQuTjBdLMsLQxjgrbtaUZJG/WSgT/Kkw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr20047903wrt.324.1604317863580;
        Mon, 02 Nov 2020 03:51:03 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.3.f.c.c.4.3.5.e.4.0.8.b.a.1.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:11ab:804e:534c:cf3d])
        by smtp.gmail.com with ESMTPSA id l16sm21413819wrx.5.2020.11.02.03.51.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:51:03 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Document that we won't support passwords in git urls
Date: Mon,  2 Nov 2020 11:51:02 +0000
Message-Id: <20201102115102.379422-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This keeps coming up, document why we don't do this and the alternatives.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b97967b487..490d57fbbf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -595,6 +595,11 @@ class Git(FetchMethod):
         """
         Return the repository URL
         """
+        # Note that we do not support passwords directly in the git urls. There are several
+        # reasons. SRC_URI can be written out to things like buildhistory and people don't
+        # want to leak passwords like that. Its also all too easy to share metadata without 
+        # removing the password. ssh keys, ~/.netrc and ~/.ssh/config files can be used as
+        # alternatives so we will not take patches adding password support here.
         if ud.user:
             username = ud.user + '@'
         else:
-- 
2.25.1

