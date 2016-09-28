Return-Path: <akuster@mvista.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 3725A60069
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 19:18:29 +0000 (UTC)
Received: by mail-pf0-f176.google.com with SMTP id q2so20304518pfj.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to;
	bh=Jj9F/KPY9HRF911p0JmyVB+3jE0XeNug8pmB31GInDw=;
	b=CrcMYLFbbD4TtAfF70y/xMqDCO3OXOy0c4QrZHXYQhlGU3KFRK8G0qC4Kf9CbUvgL1
	IY4EmBL2U7poFrfDfAYId0ptxzo+C60TbZr+zbEsLdWmUsCW33d1LIquLrGT1EyQxSap
	9fVVY7a8SUgq8z4/Gins21uLg0RD9V1Lk90MvoMrqszOx6UnS7ipWDPBgrxfxp4tR2xS
	j5HqiwCaGEa0Rhmzcc9Si892kZqyhjXb9Uk3lhOO4n7+1UOZegZZmuAsCAVR2wyPgJ5u
	2qZO12N/saNJPPsA9MfefP192kUfAfp/P9itQXE0qqxmc6E/VOAdSVSkpaPqnT6xOdtx
	dz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=Jj9F/KPY9HRF911p0JmyVB+3jE0XeNug8pmB31GInDw=;
	b=I60z1yqr5BvXmp9HBjABZ9M61t8pNaSvq7JtLZTSJmE+etoSYlzuqV6DAqY65yNVGj
	JrkXmGewDLWcDQSJ5sGeVoFRxlVCvoiHSdz+fov6jlKN+kcgOpDpH9TwOUocORxXuhFh
	BSGty8qKTNlNyo5u5euXaCK6B2H0XlqkW9MSNtqT8HdQ5cw+/cSZ/Lxx7d/Xw6FMOG2u
	gI1pz3TzPuGvHL5u8MUd7ZwmQDWi5s1rRIb33aH7U19CpOQMdi/eq7dmbpgFoa4x3RbJ
	twMn2xAtspKt2GBOoQwfkNRlqYstFS6WKRhPqNDLQK+7qXW17IAb5VdsLeoi61LOAaKS
	4O9w==
X-Gm-Message-State: AE9vXwMJP1/8kDS2/CQXwvhQLnX92LrYUDrYD8qf21RBJ7IUWstSoDmIRkhk6+2U+wbHaUgZ
X-Received: by 10.98.80.78 with SMTP id e75mr60245507pfb.131.1475090310974;
	Wed, 28 Sep 2016 12:18:30 -0700 (PDT)
Received: from [10.22.11.190] (50-233-148-156-static.hfc.comcastbusiness.net.
	[50.233.148.156]) by smtp.gmail.com with ESMTPSA id
	70sm14364616pfy.81.2016.09.28.12.18.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Sep 2016 12:18:30 -0700 (PDT)
To: Christopher Larson <clarson@kergoth.com>
References: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
	<1475075668.30475.72.camel@linuxfoundation.org>
	<49f3c7f6-b330-b11d-e5c5-7a96b2e2a367@mvista.com>
	<CABcZANnYrgzeU22zQeHzsSePGF2-diaVUY_qjNe9vk3POCYyQA@mail.gmail.com>
From: akuster <akuster@mvista.com>
Message-ID: <2a51344a-ed2c-dca6-cd1d-9b3b6f5c9848@mvista.com>
Date: Wed, 28 Sep 2016 12:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CABcZANnYrgzeU22zQeHzsSePGF2-diaVUY_qjNe9vk3POCYyQA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Armin Kuster <akuster808@gmail.com>
Subject: Re: [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Wed, 28 Sep 2016 19:18:30 -0000
Content-Type: multipart/alternative;
	boundary="------------8B5DF5D026D4C245536F24E9"

--------------8B5DF5D026D4C245536F24E9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/28/2016 12:12 PM, Christopher Larson wrote:
>
> On Wed, Sep 28, 2016 at 8:25 AM, akuster <akuster@mvista.com 
> <mailto:akuster@mvista.com>> wrote:
>
>     On 09/28/2016 08:14 AM, Richard Purdie wrote:
>
>         On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:
>
>             From: Richard Purdie <richard.purdie@linuxfoundation.org
>             <mailto:richard.purdie@linuxfoundation.org>>
>
>             "hash() is randomised by default each time you start a new
>             instance
>             of
>             recent
>             versions (Python3.3+) to prevent dictionary insertion DOS
>             attacks"
>
>             which means we need to use hashlib.md5 to get consistent
>             values for
>             the codeparser cache under python 3. Prior to this, the
>             codeparser
>             cache was effectively useless under python3 as shown by
>             performance
>             regressions.
>
>             Signed-off-by: Richard Purdie
>             <richard.purdie@linuxfoundation.org
>             <mailto:richard.purdie@linuxfoundation.org>>
>             (cherry picked from commit
>             12d43cf45ba48e3587392f15315d92a1a53482ef)
>
>             We kept running into an issue where shell scripts were not
>             getting generated on 32bit hosts. It seemed to be caused
>             by this
>             code.
>
>         I'm puzzled. This patch is in master. I'm therefore assuming
>         you're
>         suggesting this for 1.30 but it doesn't say that anywhere.
>
>
>     We made a similar change in our bitbake sources for 1.28 which
>     needed to be submitted per the Yocto compatible requirements.   I
>     could have sent that one but then you might have said "Hey, this
>     looks like the one in Master, why are you not using that one?". 
>      I personally like to reference upstream official fixes than hand
>     crafted ones that achieve the same result. I can send you the one
>     we did if you want.
>
>
> I think the problem is you didn’t actually say what version/branch you 
> wanted it applied to, not which commit the patch references..
oh.. I did didn't I .  that was lame. apologies.

I can resent to add version to the subject.

-armin
> -- 
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics


--------------8B5DF5D026D4C245536F24E9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 09/28/2016 12:12 PM, Christopher
      Larson wrote:<br>
    </div>
    <blockquote
cite="mid:CABcZANnYrgzeU22zQeHzsSePGF2-diaVUY_qjNe9vk3POCYyQA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Wed, Sep 28, 2016 at 8:25 AM,
            akuster <span dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:akuster@mvista.com" target="_blank">akuster@mvista.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">On 09/28/2016 08:14 AM, Richard Purdie wrote:<br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:<br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    From: Richard Purdie &lt;<a moz-do-not-send="true"
                      href="mailto:richard.purdie@linuxfoundation.org"
                      target="_blank">richard.purdie@linuxfoundatio<wbr>n.org</a>&gt;<br>
                    <br>
                    "hash() is randomised by default each time you start
                    a new instance<br>
                    of<br>
                    recent<br>
                    versions (Python3.3+) to prevent dictionary
                    insertion DOS attacks"<br>
                    <br>
                    which means we need to use hashlib.md5 to get
                    consistent values for<br>
                    the codeparser cache under python 3. Prior to this,
                    the codeparser<br>
                    cache was effectively useless under python3 as shown
                    by performance<br>
                    regressions.<br>
                    <br>
                    Signed-off-by: Richard Purdie &lt;<a
                      moz-do-not-send="true"
                      href="mailto:richard.purdie@linuxfoundation.org"
                      target="_blank">richard.purdie@linuxfoundatio<wbr>n.org</a>&gt;<br>
                    (cherry picked from commit
                    12d43cf45ba48e3587392f15315d92<wbr>a1a53482ef)<br>
                    <br>
                    We kept running into an issue where shell scripts
                    were not<br>
                    getting generated on 32bit hosts. It seemed to be
                    caused by this<br>
                    code.<br>
                  </blockquote>
                  I'm puzzled. This patch is in master. I'm therefore
                  assuming you're<br>
                  suggesting this for 1.30 but it doesn't say that
                  anywhere.<br>
                </blockquote>
                <br>
              </span>
              We made a similar change in our bitbake sources for 1.28
              which needed to be submitted per the Yocto compatible
              requirements.   I could have sent that one but then you
              might have said "Hey, this looks like the one in Master,
              why are you not using that one?".   I personally like to
              reference upstream official fixes than hand crafted ones
              that achieve the same result. I can send you the one we
              did if you want.</blockquote>
          </div>
          <br>
          I think the problem is you didn’t actually say what
          version/branch you wanted it applied to, not which commit the
          patch references..<br>
        </div>
      </div>
    </blockquote>
    oh.. I did didn't I .  that was lame. apologies.<br>
    <br>
    I can resent to add version to the subject.<br>
    <br>
    -armin<br>
    <blockquote
cite="mid:CABcZANnYrgzeU22zQeHzsSePGF2-diaVUY_qjNe9vk3POCYyQA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">-- <br>
          <div class="gmail_signature" data-smartmail="gmail_signature">Christopher
            Larson<br>
            clarson at kergoth dot com<br>
            Founder - BitBake, OpenEmbedded, OpenZaurus<br>
            Maintainer - Tslib<br>
            Senior Software Engineer, Mentor Graphics</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8B5DF5D026D4C245536F24E9--
