Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786BD41149
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 09:30:32 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31892.1768469425023106126
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 01:30:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jjVrkrzc;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c533228383so45335285a.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768469424; x=1769074224; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OOWsKktApp3U/eogjgy/UoL4cRQwv/kYhXg9NnJyZmg=;
        b=jjVrkrzcV+F3pCg7WzdGIZTrNhoGUkwzHLLrrax+JQuf0HjBU7xgPDA+xngrj9gYXi
         9PvJ7TWV2wSeGW+bJIYMuKj+r1zpJP7eFxmlo5VnTD7lD6KOuTKD8FW6xlJFq4ox8ddY
         3tjM6qAUK0ZKbW0XVhidaI0vkK+DTmgOTMyjv292utuDkW+1rUn+iwcmQguFt9R7dMVb
         Txq0Y4XaaKyw3+cP6kITsgZdjaORWCmPwzCza/FYZ4VjMA+Qn8cIg9l4LNazRNfhSKUV
         oozSSzxMFZaQOmKJzLwxiJnx+hlCnJ+j5XHg20EKm/WqFmMFYBIqa5NXLMG7YsQw7L1C
         8W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469424; x=1769074224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOWsKktApp3U/eogjgy/UoL4cRQwv/kYhXg9NnJyZmg=;
        b=PZonqLj8HzCDxlRsJaILyuAt/wFB8vZkdPfJjDbpoQnR2QyXBSbG+mGGyqDdEYx0YK
         dpOfFMO7cnA2/c8n0i+fxFpVrC/dDPJaJpj8A6+95zDirKsCQB1VHQ7i7QNDd8wwr777
         RQa3yag+c167X+Mq3Bc4aFD7K5OTzeYjYvqrTzchWXpwLZQ4RDdYpeBTXgWpnlkiGRZh
         YN0/MReSrKyPgIf9+cKqb3AqwJh2D+WodR0JPZEsVYHhN90jGZo9UphdoETzArNcEOxb
         KfesOt6phGZjaCXysD5WHbwCTfqUjYjwvxnATBPvSeLbJbv1ofWKKjLRNrqgFZB+X5R5
         8+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOG+KP6iPYU3TOwIxSqSWqtnKsXLGqbKgI2bpskF+9+byvXwtWkP4WAGEdZtJjyn2EmBlmWzlx5VHDPzpa@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxx/xbfL6HeTFUQsaktKRseL3rXjq6EFN7jFLFzOtMauefpeAW9
	w9rc2HvIpU+rhtc8CE+zPYnN9MnBdCnAN8Jn56TuhPJiePEHWmPcSS87pxFdNNwOFXSqeKJJGLt
	gfplyNrfZiMmEHKCEZUuxJcpK/dBP9EQ=
X-Gm-Gg: AY/fxX769Nqohof5bO2Owny0P39Qyyp4n44Oj3D1HR59T8FLaqOz3mzF5iXiw7vEmk3
	rdJc7tkDT0hcKByc08/84eSir+81oEBAe75hqAwDz3xHUwFr21qif3t/AH2LUugrrbj9MUJe7KU
	roxx+yjDOSLq5E4RkWWmkhuyr5bucpknP1hHcyU8cYaTinPimN1DGYl3cAdQxmQ8goT8QnG0Gl+
	bNMJhQNjhqLgqZrFHsM3MFwTGfsx6DGPVGNCZLodtfHmIJM4UYcBVSWQy1DJab7zRPBifUu
X-Received: by 2002:a05:620a:290f:b0:8b2:7777:f641 with SMTP id
 af79cd13be357-8c52fbf3759mr820579185a.64.1768469423818; Thu, 15 Jan 2026
 01:30:23 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
 <DFOEW0JK0R5M.RI0FHSXWERO2@bootlin.com> <CA+HEL7_b1WJRAm+hO_JqZX0X36HhOVtX9w8vkDHvVK+XThcPag@mail.gmail.com>
In-Reply-To: <CA+HEL7_b1WJRAm+hO_JqZX0X36HhOVtX9w8vkDHvVK+XThcPag@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 10:30:12 +0100
X-Gm-Features: AZwV_QjvBvtsFAgzB0FK6_X37-NuLu87sxATwDHXsJLZaKP0DXv8LCFKXuWqY-Y
Message-ID: <CANNYZj-oyF172VoYsTymaTNMv0y2-yqpzg_ewE0eVczYq4M_NQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
To: daiane.angolini@foundries.io
Cc: antonin.godard@bootlin.com, otavio.salvador@ossystems.com.br, 
	bitbake-devel@lists.openembedded.org, 
	Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 09:30:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18769

On Wed, 14 Jan 2026 at 19:38, Daiane Angolini via
lists.openembedded.org
<daiane.angolini=foundries.io@lists.openembedded.org> wrote:
> We always knew bitbake-setup is in early stages, and there is a long
> way until 6.0/may, that's why we started this conversation by asking
> the basic questions: What is the expected list of features of
> bitbake-setup by the next LTS and if bitbake-setup python package was
> expected to be part of the LTS bundle before even start talking about
> terminology. My goal (and I think I can say our goal and include
> Otavio here) is more likely to be understanding where the community is
> heading than making demands.

These questions are not particularly easy to respond to, and not all
of what I want to say is 'pleasant'. I have a list of patches I'd like
to get through the patch review:
https://github.com/kanavin/bitbake/commits/akanavin/bitbake-setup/
There's another patchset from Corentin aiming to simplify sources
format in the json. Adrian wants to integrate VSCode support. Rob
wants to have a working pypi package, for which I wrote a patch to
fall back to configuration registry if no internal registry is found
(which is the issue you've reported). This patch is also in my patch
queue.

None of the above is a 'promise' or 'expectation' that it will happen
in time for the LTS. Open source doesn't work that way. I'd love to
implement all of the bitbake-setup wishes I got from you and others,
but there's a number of high priority issues that need addressing, and
they will take an unknown amount of time:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=16087 and a long
list of other issues. You've been on the tuesday call, and you should
know where help would be most appreciated.

Alex

