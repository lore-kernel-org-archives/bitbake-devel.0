Return-Path: <uvv.mail@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90CD61017
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 13:42:27 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14850.1769694139095470824
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 05:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nf86q+Ll;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: uvv.mail@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbc305914so972740f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769694137; x=1770298937; darn=lists.openembedded.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uYNl9ROmXNRiFaxybo7IMVNJEIMFn9RRRgIKJ8A6fc=;
        b=nf86q+LlvRpbBlj8ErV6Wqma/QJ38oQQwCDWexjhM+2D2G164CG7oDi7PCEElbLcZC
         AME78MFjokqJQtki2PG40cFJ1KriB88z/UWSb2DPCt7U1gsw1ktC41SIzfxM7I8C4tTQ
         SGQqgpLdENVBm0iSc6cr8KiMSH/SxTA0F6XgxAAG72o06IP9M3GUcKzSncn5VhRbzJBp
         wzt0e4hY6QvnvOrPk9TzN8Ou7NUDbBxrM3HTKDq08nPzMJ7k8gdWJ7TyXrotIqXHT4hb
         OrFjwGPNsadP5QBl0tnTobR4qSe4Ga0dyUWW/N3nTMld6cadiD+u6+Szl3Ox1vQs37aa
         8y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694137; x=1770298937;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uYNl9ROmXNRiFaxybo7IMVNJEIMFn9RRRgIKJ8A6fc=;
        b=MYIy+7WhzUZIWrSAg1J921HnBRpwotOF1r2t2wZaOSHdyLaMr+A3aUjXIIEKk5vTjK
         i117Zh8ux/IlUtVsYJnW3z+t0PlStpFYmE43axlzy7o7fDmjtZvXDbVYOk034KihT8KX
         kiafpHfdn1/9JURJ2xLHGrBDPEEeCwxBkYWlDL3kVYJH4KzNURitOcng6hhjpRWnbbvI
         eFMnN9+/oycadCi9haKP6U8v+yeeV92RreeQIdH1AkBwaUmHYMsKBiCROuRm9uwcT7vC
         YNu8FxeI2r2HLW1FKkhKZVzGajhEXm5XgoVF0BQ2qTfM7V3cLXgLMLCbXdW8E7enL8qv
         3JcA==
X-Gm-Message-State: AOJu0Yz4LB9W8/eSlSGCUl0brHGjgdEi1vhEMbfzhjoCBno+by4ObSoH
	JQjTmf3ENdE2tMAus/OJ9wA/UjMV+ddsVd4yLAIO830nbhUqgZFaHyUH
X-Gm-Gg: AZuq6aIJqjYIDJliuAIpS4BY5wjhOOMWLmWn10rdt4gFZ59XrSccU1+9qBG42sEqkOi
	XJraAQ23zxYtMUsJDaohVrCc+fxiRRvt5o2QihWy/YJZla6Z2gA6eVPyIa+02EtydlWLZOR7Pux
	hxQa/yoMw61MjMmnDZPMEXk4eIqSi5yF3yUeJYyMTIjdy+6gLN1TXhnv0jypULox9OAqZzL+ivK
	uO80VhJ1ud9HGmvW4DStYzHEF9VazAuMlvVJRVmZVXLuC5O3bvICHXZm2MOBcggJTf2SaizclVJ
	x5Lmq7fI3xllcC71ymRkoa84bqQwJGQ4I2SjM81Q5MmFEtWJk1rY2pHEZBGs0eK9b/+T+VT1NIN
	7nfkaDYaidjOwAeKZig8p+sMAw9D3lQziquy6FNC63l8hMZTtpJdAlQVj5mfEe+nOqgmbmfjZ/W
	8ubJyJXtmhGgCYagDuvxiR9xVQ7Q==
X-Received: by 2002:a05:6000:1ac7:b0:435:9bf5:b336 with SMTP id ffacd0b85a97d-435dd0719ecmr13374555f8f.19.1769694137103;
        Thu, 29 Jan 2026 05:42:17 -0800 (PST)
Received: from [10.54.7.179] ([154.47.27.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4824sm15547098f8f.1.2026.01.29.05.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 05:42:16 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------qVibcXdYQNcZXklsbkCTAhz0"
Message-ID: <6327151f-ccda-4b63-9757-e50acd6b6853@gmail.com>
Date: Thu, 29 Jan 2026 14:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Alexander Kanavin <alex.kanavin@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, Yoann Congal <yoann.congal@smile.fr>
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
 <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org>
 <18870377D56AF168.1986633@lists.openembedded.org>
 <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
 <df05a1fd-23ba-45be-886e-886e4a79cb74@gmail.com>
 <DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Vyacheslav Yurkov <uvv.mail@gmail.com>
In-Reply-To: <DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 13:42:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18935

This is a multi-part message in MIME format.
--------------qVibcXdYQNcZXklsbkCTAhz0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.01.2026 14:48, Peter Kjellerstedt wrote:
> I'm not sure why you are pointing at repo here, because this is actually
> a use case that repo handles extremely well. We have been using repo for
> over ten years to maintain the manifests for all our builds, and (AFAIK)
> we have not had a single case of repo loosing any data due to doing an
> update.
I didn't mean that it loses the data. I meant the need to run some other 
command _using_ repo so it is aware of what happens in the repository.

Slava
--------------qVibcXdYQNcZXklsbkCTAhz0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 20.01.2026 14:48, Peter Kjellerstedt
      wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">I'm not sure why you are pointing at repo here, because this is actually 
a use case that repo handles extremely well. We have been using repo for 
over ten years to maintain the manifests for all our builds, and (AFAIK) 
we have not had a single case of repo loosing any data due to doing an 
update.</pre>
    </blockquote>
    I didn't mean that it loses the data. I meant the need to run some
    other command _using_ repo so it is aware of what happens in the
    repository.<br>
    <br>
    Slava
  </body>
</html>

--------------qVibcXdYQNcZXklsbkCTAhz0--

