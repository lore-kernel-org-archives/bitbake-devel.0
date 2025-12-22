Return-Path: <uvv.mail@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C93D711D5
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 09:14:10 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76934.1766394845580166342
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 01:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NvdyEmfK;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: uvv.mail@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b76b5afdf04so540159666b.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766394844; x=1766999644; darn=lists.openembedded.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyI1mpQk89OFvBrCMI8rqsvu6jzCugKMFiqTZziNQqs=;
        b=NvdyEmfKUbvuKnDsUI4BXXyVjF/ElVOgcRgpX1OSNUJD4y5apqHZ5r4JxzGfVT+0iS
         FFO5VCC8gr4CIQzHJacbudsSCp+ISe6L0RWSTFp5h9farMwQbekhTv1TnP1c/933qAZ9
         KaI2mibbGG1kvtz//qEHPbAx/BNgl2Wd4bODOoQ87qQm+x9uylu4A2IFxX7i5Wjvxvz0
         KOq7LrYKM63Yh+XlOs6KVmxTCCvBQtwG3San00sWkPHy3QuSSwMBQ53uHEV5vfLZRNo9
         6wGryATmYlLz0MhjSU+8KqmSlhzzzpvEYlgqh7V/TzxJCysxggbkRaLiRL+Z6T7vEcLd
         gzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766394844; x=1766999644;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyI1mpQk89OFvBrCMI8rqsvu6jzCugKMFiqTZziNQqs=;
        b=OC+5AuIpJrrXIhLxUkZIWp2IH2v8QXxcFkYdWkLo/hG8ZCsei4qprCE+efYOCRBVSX
         ZbwA5VdTHTxN/aPjRzVW2WySefJR3B4ZAF8lzJltYkoWo+p/oYB6J27D+D1cdwrfadtm
         gC2frXyPmTnNoJoKkJH0gWsU68dnZSSjhMesjd7dFoKfG0A1m8GxMsUC/nC4nYOdgl75
         Ebii+paUrUjZMETB1xQ496sFWvp3arp/nHuQTUAmE4SVoFK5iQssV/2mJp6IRoIsldnB
         ZgoETKKX6NVt9ErnwuLSi+Cs99d3qrjpr64FTkMu+ksSBu0XnOj3omAFpUdIfCImIiul
         q6Og==
X-Gm-Message-State: AOJu0Yw25UYfspWGvIZZBZBUto65B1S/jenGs5/nCjfFzJ4BrBxpK9nw
	y0H4u1pdfyOTC1WvD1fWv/luv0YjN10mGxv4coFzDbyg0WdRMCt8fd/m
X-Gm-Gg: AY/fxX5QVYWaQQ+L4J/KfS3IDHRtlajgc2yWSLI5t4F7R313Oxna4FKS0Mjc8vwT6U4
	/H8tCC45XqmH2YOWCLpUCgVT+qyaHlvzDm8zFnhbR2uHspUO3+NvGTBIjlas238ibvQilZIAfBn
	MH6d2EigmXJ2zAbdR5fRk55u0r+meRQNyD3OBGr6rqbJgPrtToTq3dN9OsiDpctrMmPS7Z2ZeWH
	XMJ4r5XwbTxuYL0IEB71xqYTbmEjgGSQ5bTtqKYrQEykMGqJuirlc/tYtgLdEX/aGqSsZYxAYVq
	MHmC/2z/VfpFFPxdkoRi1UbeR1lGwX3mUypunBh8oCRlauJFMydj0sDDfNq194LMu18a8HCk3SS
	73RwgtVhMjNJL2ga3FrSR24+NsWyGUIebgmSXUBxU+7ufiyBZQhkE3Oj8kbmd/tGOhK69aqG3jD
	AMvDG+Z/jmKycqpFS3wewKOR4zgxg=
X-Google-Smtp-Source: AGHT+IFEp0ScADiNcrS2aH1BmPDae4bWOvucFayIRRyojG3f1fZf0knnNxjoLGEMqjkCfV5eo4b2Jw==
X-Received: by 2002:a17:906:5a6c:b0:b80:4158:d9c2 with SMTP id a640c23a62f3a-b804158e0f4mr558759466b.1.1766394843745;
        Mon, 22 Dec 2025 01:14:03 -0800 (PST)
Received: from [10.54.16.211] ([154.47.27.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cc52sm1009340866b.52.2025.12.22.01.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 01:14:03 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------HHQF45zftiV0P1hJ8hxY0SZZ"
Message-ID: <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
Date: Mon, 22 Dec 2025 10:14:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
Content-Language: en-US
From: Vyacheslav Yurkov <uvv.mail@gmail.com>
In-Reply-To: <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 09:14:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18633

This is a multi-part message in MIME format.
--------------HHQF45zftiV0P1hJ8hxY0SZZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.12.2025 10:09, Yoann Congal wrote:
>
>
> Le lun. 22 déc. 2025 à 09:56, Vyacheslav Yurkov via 
> lists.openembedded.org <http://lists.openembedded.org> 
> <uvv.mail=gmail.com@lists.openembedded.org> a écrit :
>
>     It turned out to be a painful discovery.
>     I wanted to rebase my custom branch in oe-core on top of latest
>     master
>     before publishing a set of patches. But it seems like after running
>     'bitbake-setup update' my branch is nowhere to be seen. Is it
>     supposed
>     to be like that? Any chance to get it restored?
>
>
> Try "git reflog HEAD", you should see every commit HEAD has been on 
> (and, in theory, the commit at the tip of your branch)
That's the first thing I'd tried. The whole layer seems to be a fresh clone.

Slava
--------------HHQF45zftiV0P1hJ8hxY0SZZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 22.12.2025 10:09, Yoann Congal
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">Le lun. 22 déc. 2025
            à 09:56, Vyacheslav Yurkov via <a
              href="http://lists.openembedded.org"
              moz-do-not-send="true">lists.openembedded.org</a>
            &lt;uvv.mail=<a
              href="mailto:gmail.com@lists.openembedded.org"
              moz-do-not-send="true" class="moz-txt-link-freetext">gmail.com@lists.openembedded.org</a>&gt;
            a écrit :<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It
            turned out to be a painful discovery.<br>
            I wanted to rebase my custom branch in oe-core on top of
            latest master <br>
            before publishing a set of patches. But it seems like after
            running <br>
            'bitbake-setup update' my branch is nowhere to be seen. Is
            it supposed <br>
            to be like that? Any chance to get it restored?<br>
          </blockquote>
          <div><br>
          </div>
          <div>Try "git reflog HEAD", you should see every commit HEAD
            has been on (and, in theory, the commit at the tip of your
            branch)</div>
          <div> </div>
        </div>
      </div>
    </blockquote>
    That's the first thing I'd tried. The whole layer seems to be a
    fresh clone.<br>
    <br>
    Slava
  </body>
</html>

--------------HHQF45zftiV0P1hJ8hxY0SZZ--

