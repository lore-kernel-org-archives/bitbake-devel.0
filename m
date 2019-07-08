Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
	[209.85.215.175])
	by mail.openembedded.org (Postfix) with ESMTP id B05876BC19
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2019 03:06:21 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id o13so6877668pgp.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 07 Jul 2019 20:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=to729HllAHcCHYJ1ATlUJ1nkLX13NFjqOcQGeocyYYA=;
	b=qLgsul2SKt5eTTCkl8vwlAgTdxFntZrnfiOmJpzRcSbDwRtRIcuyQWR2XWOzqEmirk
	YhQdv6JmyNrFQBc+QAhCzBv7+vAE4d5LLizcV6n4LYYqTFSpMwBrvDqnUV/x6kH2dSCl
	EyJLum7WfWXE2he7ALFGnHn7FN4bz0wDVp83dQofF3ojYPeHajZ3172Xvq4aubEmJcbo
	Jbg+xqIjWNHXlfP/NzthVs+Hr/0jjBI1j3JL7RAWyG7L5yrFtWejzAuOCJ9o2lPlbjTZ
	jBN54EVxqu2u/NlYQiTAwd3+XWkBK60Wz5CcFhzp6pO8T+oJY7TlfMJCpPYamAIH50bb
	zD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language;
	bh=to729HllAHcCHYJ1ATlUJ1nkLX13NFjqOcQGeocyYYA=;
	b=Ws+8gWRHCsXLojZ8/RJEC3K7crQMQONVpC8egls5+ZAvSpFA1pH/pskGF0kpMyMc1Q
	r3A7QD35dodQxm7LYcorFSWXFdcwxdFFM1pX7gq2eMRxrChcshG6qrPpbGcl8EA91ejY
	YVli7PszjkmD04JQQD901zX3uiYnuqrmZcotsAvXRa6joexPVdOeWjsCP2fDx+/VUVwO
	VadRqo/VkKM7fcx7euVAOKfdhNLqChFi2ZooNBl7TQaxp4xTNGmCilApWuV0878DwZYS
	mVEF2iH06omJoVYXarkmVV8MsSceGq8BGl2GTpo+8kt4d5benKVETd4xAYYq8+xJDArl
	EFsg==
X-Gm-Message-State: APjAAAXDKlvhRSwo/Bzd3febxUuS+d8tLmARFacbGr59ApqeHTXjzKI5
	1/KaVW/eNj+21V48d0JCmgkNfLF1YWc=
X-Google-Smtp-Source: APXvYqy169GKyufh7IuBYkWWHSJuahDPv2gUyRa0LTb/EGOqVj5BQpk5OPaHML6/7CgPh2Rsw5iCxA==
X-Received: by 2002:a63:3ec7:: with SMTP id
	l190mr21147254pga.334.1562555182667; 
	Sun, 07 Jul 2019 20:06:22 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:c2e:f46a:e59c:dae7?
	([2601:202:4180:c33:c2e:f46a:e59c:dae7])
	by smtp.gmail.com with ESMTPSA id
	n89sm29191513pjc.0.2019.07.07.20.06.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Jul 2019 20:06:22 -0700 (PDT)
To: Ankur Tyagi <ankur.tyagi85@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <8d94fa48-50b6-c3a6-38a4-9a680e5a6d3a@gmail.com>
Date: Sun, 7 Jul 2019 20:06:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com>
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 08 Jul 2019 03:06:21 -0000
Content-Type: multipart/alternative;
	boundary="------------CB71EE670AC1222720842C09"
Content-Language: en-US

--------------CB71EE670AC1222720842C09
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 7/7/19 12:55 PM, Ankur Tyagi wrote:
> Ping
>
> Regards
> Ankur
>

This needs to land in master first before it can be backported.

I don't see this in the patchwork either., not sure why

- armin

> On Thu, 4 Jul 2019, 4:45 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com
> <mailto:ankur.tyagi85@gmail.com>> wrote:
>
>     Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com
>     <mailto:ankur.tyagi85@gmail.com>>
>     ---
>      lib/bb/fetch2/git.py | 3 +++
>      1 file changed, 3 insertions(+)
>
>     diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>     index 59a2ee8f..a8fcc2bf 100644
>     --- a/lib/bb/fetch2/git.py
>     +++ b/lib/bb/fetch2/git.py
>     @@ -156,6 +156,9 @@ class Git(FetchMethod):
>              if not ud.proto in ('git', 'file', 'ssh', 'http',
>     'https', 'rsync'):
>                  raise bb.fetch2.ParameterError("Invalid protocol
>     type", ud.url)
>
>     +        if ud.proto in ('http', 'https'):
>     +            ud.path = ud.path.replace(" ", "%20")
>     +
>              ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
>
>              ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
>     -- 
>     2.17.1
>
>


--------------CB71EE670AC1222720842C09
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 7/7/19 12:55 PM, Ankur Tyagi wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Ping
        <div dir="auto"><br>
        </div>
        <div dir="auto">Regards</div>
        <div dir="auto">Ankur</div>
      </div>
      <br>
    </blockquote>
    <br>
    This needs to land in master first before it can be backported.<br>
    <br>
    I don't see this in the patchwork either., not sure why<br>
    <br>
    - armin<br>
    <br>
    <blockquote type="cite"
cite="mid:CADySD0E1_H-42rdzxxKSEdHYAmCLenxL+C7KWS0xkhJYqC4aBQ@mail.gmail.com">
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, 4 Jul 2019, 4:45 p.m.
          Ankur Tyagi, &lt;<a href="mailto:ankur.tyagi85@gmail.com"
            moz-do-not-send="true">ankur.tyagi85@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by:
          Ankur Tyagi &lt;<a href="mailto:ankur.tyagi85@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true">ankur.tyagi85@gmail.com</a>&gt;<br>
          ---<br>
           lib/bb/fetch2/git.py | 3 +++<br>
           1 file changed, 3 insertions(+)<br>
          <br>
          diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
          index 59a2ee8f..a8fcc2bf 100644<br>
          --- a/lib/bb/fetch2/git.py<br>
          +++ b/lib/bb/fetch2/git.py<br>
          @@ -156,6 +156,9 @@ class Git(FetchMethod):<br>
                   if not ud.proto in ('git', 'file', 'ssh', 'http',
          'https', 'rsync'):<br>
                       raise bb.fetch2.ParameterError("Invalid protocol
          type", ud.url)<br>
          <br>
          +        if ud.proto in ('http', 'https'):<br>
          +            ud.path = ud.path.replace(" ", "%20")<br>
          +<br>
                   ud.nocheckout = ud.parm.get("nocheckout","0") == "1"<br>
          <br>
                   ud.rebaseable = ud.parm.get("rebaseable","0") == "1"<br>
          -- <br>
          2.17.1<br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
    </blockquote>
    <br>
  </body>
</html>

--------------CB71EE670AC1222720842C09--
