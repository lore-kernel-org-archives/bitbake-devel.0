Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SQJhZ-0000WH-TP
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 16:41:45 +0200
Received: by wgbdr1 with SMTP id dr1so2426365wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 May 2012 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=mcd9IZCy/RvZZyFQz78udI2PDiSfUAWAdZTAL0BhmT0=;
	b=PvsHTyjodVkkFT917clUWbk1hUPyLVFv+KkXKOOzE2xg68x1MehXwunersor71fgev
	9nJMvJNC0ocfhCGOAITl+jayE5TlKaGQfCyDcrjT9TJTwPsE4GFB3/X+76foFXJteoPC
	KVoFusBZ9ss1FHFZ1Li58sEO6C5XBwpgV4Tlg+6IP+7EVSV+V9MW8lQNoqxrsUg3fq7p
	UdOAwQDkxjxnqr4n20k8jKbArqWVMEF/7p2F4DxV55mldP9P+xX275YICh2VugK2XS9p
	ZgeUTFlDLl1pz5b6Rom2NeKWx4nVtTHWXvP690lFEMO7zxzAK4DqjrsVVVM/6qqjalbx
	vk2Q==
Received: by 10.216.138.5 with SMTP id z5mr4209858wei.27.1336141918237; Fri,
	04 May 2012 07:31:58 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.27.148 with HTTP; Fri, 4 May 2012 07:31:37 -0700 (PDT)
In-Reply-To: <1336140213.23777.4.camel@ted>
References: <1336140213.23777.4.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 4 May 2012 07:31:37 -0700
X-Google-Sender-Auth: IxCf4p3d5-tkGEFlsj42yjKn_bM
Message-ID: <CABcZANm1yKZ3rj1YV7WXbWO3vwoWbK11iHKGMkRDmF8sFzXTgw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/utils: Convert vercmp_string() to use vercmp internally
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
X-List-Received-Date: Fri, 04 May 2012 14:41:46 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, May 4, 2012 at 7:03 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Having two different version comparision algorithms in bitbake has never seemed
> like a sensible idea. Worryingly, they also return different results to each other.
>
> The vercmp_string API is relatively unused with no users in OE-Core or BitBake
> itself for example. This patch converts it to use vercmp internalls, bringing
> consitency to the comparisions which is easy now we have other recently added
> functions. Yes, this changes behaviour but in this case I'd prefer we were
> consistent than having two different comparisions.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

This seems sane to me (aside: minor typo: internalls). I recall that
we attempted this once in the past with regular OE and got bitten hard
by the actual users in the metadata, but clearly that's no longer a
concern.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson


