Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <oren@ephemeron-labs.com>) id 1S7XDw-0000wH-I6
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Mar 2012 20:17:32 +0100
Received: by ggcy3 with SMTP id y3so925804ggc.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Mar 2012 12:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=JgziqfC1KZsQSOj9Iv0psrgHxVFcRE/5HENb2z4PZ28=;
	b=iu21IFlVPiTi2+zPFPS84VBFZbT8//Qz2La11a5f9h2+CGjz7DvKmUNt74rrmBXMkm
	oCN4N6jLcL2z+Jy9suu1O9A/efEl7dey0TDOnJPsjgN7mATiP/RsQ3LtsA1jcveRZNOW
	BFOievnoRbehUa5qIv5uHzEPhA6g28UkEl7/Rei4sQH1qS5+fyq4zqjuhEu5fY+W1HqL
	1CftEQqUjjflTGJnyJnivTW1SAHowRbQQHS7E/e3dwxwbsm57S1GZRd1qkNk7t4lzYEf
	Apo/5LIdOtzYArbne0fIxxIe1L5fQsR5CqUavlUvRTnBdI4CKJjt0Kuv7ekg1lvsmmsS
	Ob9w==
MIME-Version: 1.0
Received: by 10.60.14.36 with SMTP id m4mr12985665oec.37.1331665727491; Tue,
	13 Mar 2012 12:08:47 -0700 (PDT)
Received: by 10.182.19.7 with HTTP; Tue, 13 Mar 2012 12:08:47 -0700 (PDT)
X-Originating-IP: [76.99.59.229]
In-Reply-To: <4F5F8D0F.4010607@linux.intel.com>
References: <cover.1331558220.git.shane.wang@intel.com>
	<a5a40bda286914ab82e99d22da1e39e63ccace31.1331558221.git.shane.wang@intel.com>
	<4F5F8D0F.4010607@linux.intel.com>
Date: Tue, 13 Mar 2012 15:08:47 -0400
Message-ID: <CALvD2LhvZB_ESbLp9s6Xa0w0WcEJWUG4v1gkh5sSYbfKBYBGEA@mail.gmail.com>
From: Oren Leaffer <oren@ephemeron-labs.com>
To: Joshua Lock <josh@linux.intel.com>, "Wang, Shane" <shane.wang@intel.com>
X-Gm-Message-State: ALoCoQnE6/sUdReqIKM7AV4Uj1C9QjyWD2xVIGAPmgX0V8SH1jzHopon4/xlQ/h7IjnfGECc6Me3
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] Hob: implement a self-defined notebook visual component for Hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 13 Mar 2012 19:17:32 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> 1) We're doing the range dance rather than just doing the Pythonic thing =
and
> iterating over the sequence with "for x in y".
> http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html#use=
-in-where-possible-1
>
> I understand its desirable to have the index in some places, but where it
> isn't we should use the standard pattern. This is good coding practice.

I think I pointed it out before, but it was on a Friday, so I might as
well repeat -

If you need the index you can replace something like this:
 =A0for i in range(len(self.children)): # ugly
With:
  for i,child in enumerate(self.children): # less ugly!


Best regards,


Oren


