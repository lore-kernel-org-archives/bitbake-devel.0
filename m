Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SA0A2-00013p-Mj
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:35:42 +0100
Received: by qao25 with SMTP id 25so122197qao.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Mar 2012 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=4QI10c/7qmEZS4GBKNYuGW8n5Oxc4R1TqaKbaU4l+Y0=;
	b=vVeQzkaWU7zsZqwIx47Tl7kBHvtnGF2HsfUw0LHH+JPh02AoNqJkFmZajXj8UZZHzu
	AHd9IejGA2sRekw1cKOQuQoSmrod7fXJhhtw+SXmLPoI2UJIo31vLMhI7DcBs+1+aYEB
	54A1sN9POylKaniRvZnnrcplLlGVf1yi0jl4bDRgn87bJIkM43QIcbFwuizkJXcocBVD
	YpLIwhLO7DOqLpzslrFqCCrVFnmv9efB6eQCBHgxo/SUsuycpAwNbu+lARsz2op7LM3Y
	B7SBEkcnQKAXqzO/AlswhOOvbM0IfG615eQSAbCc29TQPDL1PKkMvy8iapq/I+8+ez1v
	F4VQ==
Received: by 10.229.78.227 with SMTP id m35mr69404qck.0.1332253609908; Tue, 20
	Mar 2012 07:26:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.103.147 with HTTP; Tue, 20 Mar 2012 07:26:29 -0700 (PDT)
In-Reply-To: <4F6882EE.5080704@mlbassoc.com>
References: <4F6882EE.5080704@mlbassoc.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 20 Mar 2012 07:26:29 -0700
X-Google-Sender-Auth: fOOqcx-bfufMuOYkDISrYkpXoSo
Message-ID: <CABcZANmcjghvLZy+gu6i5iqBfLg13CJg8+FyOABFq633q_Mi4Q@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: BBMASK doesn't work on .bbappend?
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
X-List-Received-Date: Tue, 20 Mar 2012 14:35:42 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 6:15 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> I'm trying to include only part of the meta-ti layer into my mix,
> so I have this in local.conf:
> =C2=A0BBMASK =3D ".*/meta-ti/recipes-misc/:.*/meta-ti/recipes-bsp/"
>
> Both my layer and meta-ti layer have a file formfactor_0.0.bbappend,
> but it seems that the meta-ti/recipes-bsp/formfactor/formfactor_0.0.bbapp=
end
> is being processed as well as my own (and breaks my .bbappend file).
>
> How can I keep this file from being used? =C2=A0I need other things in th=
e
> meta-ti layer so I'd like to come up with a "soft" solution, e.g. using
> BBMASK (which works great for the .bb files)

I'm using BBMASK to mask out a few bbappends from meta-oe -- we can't
use it otherwise at this point. Also, BBMASK is a single regex. that :
you have in yours looks questionable, unless you actually have a colon
in your path. More likely you wanted | there.
--=20
Christopher Larson


