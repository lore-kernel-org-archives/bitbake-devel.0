Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D7C4706F
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 09:39:42 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.217297.1704015579343748350
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 01:39:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Lz8qMFIQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso4652846e87.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704015577; x=1704620377; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=trR6KpjuwrwjYtJZvwCNCBWLcxy2LQzLTgnxvm7faAU=;
        b=Lz8qMFIQAO6tk8zkECUp0NHzT+csmFUKIVNPuAkoWhcLPVoz3B93ybXb1g/2gZTFfD
         PS41L1Uw/0mfkbn3IapngGtGGdmnrvmlEPw2x+waXae9hAE3gEdIgA8kq04mOnO1NQ+o
         sDmKO81HJ+/ShuOb91PivuBXfEiTLPDL3SMukuRCQREQtflG6fXqusHch6ee3F1bazJV
         ImhY1uxIPHkq8v8luPYWWCi+2n9A5B9mN43hs92IG5U1mDazZZd0vAFy4E0ZOLnRapSe
         LIGcLmeJW1wAroM3GO8R05LdQu6rTDgFSy2mLUgc2oH7/BuzHbdc7+re4rluEkS4dB41
         oqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015577; x=1704620377;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trR6KpjuwrwjYtJZvwCNCBWLcxy2LQzLTgnxvm7faAU=;
        b=N7/J+6QTMLxROeW6kdnvMwO23tzr8/uLjLiPCdJofGQGatYZ/p6/RxiZB9Ar5hDyXz
         BDb8Dcnv1hbubsfd1W3bHCoYBo6i0djV6wRRspKI4Re7Q1rrregQm5isON9fQzmm4bTp
         zSK4i85QBMypo8GKEUd0qyPXmtTGVv9xq848v88NJkHdXjCsqXx3ZZfGGbnevA19EZJy
         0mPLUAm7gz3L/PPnxhHMZQbv2hqImU2od2Rh8LnT+CbdgO6OEhagTXe8OOrclIOC/Mwo
         cK02J2ZbH6oXhqOYlhf5DSInQN61vQfbkvqeJgqErNlTICfW02baedMbSopIW/u5HWDc
         R5NQ==
X-Gm-Message-State: AOJu0YxiSiN9TsI5jVxmIgMIXepUMCJATBPFl3uEM5ozBbLGfqsu4siI
	tFVxWqfkr/1LA67sWK6IP5QXFlNMN/T6J46w6GNQnHva6ms=
X-Google-Smtp-Source: AGHT+IEA450csKRUbuu3FDcM2Xs7UJfw8bK2k9fn1Z6MhZIqv8PKr5EOCHxvyvfAq8NIDzkaLJPuAYYZlCHtOyiuI0I=
X-Received: by 2002:a05:6512:220f:b0:50e:7e15:a9cd with SMTP id
 h15-20020a056512220f00b0050e7e15a9cdmr6125550lfu.18.1704015576979; Sun, 31
 Dec 2023 01:39:36 -0800 (PST)
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 31 Dec 2023 10:39:26 +0100
Message-ID: <CANNYZj-eNGeQhM6cVhPHF1WgG3d2_nu1bsobWXfW_3HmAWUVBg@mail.gmail.com>
Subject: bitbake/lib/hashserv/sqlite.py:294: DeprecationWarning: The default
 datetime adapter is deprecated as of Python 3.12
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Joshua Watt <jpewhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 09:39:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15731

Hello Joshua,

I'm seeing this with python 3.12:

/srv/work/alex/poky/bitbake/lib/hashserv/sqlite.py:294:
DeprecationWarning: The default datetime adapter is deprecated as of
Python 3.12; see the sqlite3 documentation for suggested replacement
recipes
  cursor.execute(query, data)

The documentation that is supposed to help (but doesn't, not for me :) is:
https://docs.python.org/3/library/sqlite3.html#default-adapters-and-converters-deprecated

Just thought it would be good to address this warning well in advance
of it becoming a hard error.

Alex

