Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1S0cZW-0008KY-M2
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 18:35:14 +0100
Received: by qadz30 with SMTP id z30so7920129qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2012 09:26:52 -0800 (PST)
Received-SPF: pass (google.com: domain of kergoth@gmail.com designates
	10.229.76.26 as permitted sender) client-ip=10.229.76.26; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of kergoth@gmail.com
	designates 10.229.76.26 as permitted sender)
	smtp.mail=kergoth@gmail.com;
	dkim=pass header.i=kergoth@gmail.com
Received: from mr.google.com ([10.229.76.26])
	by 10.229.76.26 with SMTP id a26mr1638879qck.126.1330018012768
	(num_hops = 1); Thu, 23 Feb 2012 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=r6Awg+hGGk57ZDf0REjeJsRqLCLdxvZVyEMGJyhuf6c=;
	b=ROH/C6TSQt53k5rID9HolwOwCLMrg2/wbmUa3fgjBxM2DvDOLVKrmC73NBJAlxaihp
	1WH7mUdKm97HLCsxzxhoH4OlpfuKVrW8yqTCqX8nX8Ow2XpGhWiep5r3aBA2seNDJiSF
	b+D4smyyMYyt1pno9BjS2VGB9dpTD5p8x0+eo=
Received: by 10.229.76.26 with SMTP id a26mr1398755qck.126.1330018012655; Thu,
	23 Feb 2012 09:26:52 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.224.145 with HTTP; Thu, 23 Feb 2012 09:26:31 -0800 (PST)
In-Reply-To: <4109374.xIp3Nx6jlj@helios>
References: <cover.1330011581.git.paul.eggleton@linux.intel.com>
	<e22cf3ce86bd3e323c67f0b905b2211efdd334a2.1330011581.git.paul.eggleton@linux.intel.com>
	<CABcZAN=Q2TqdGABOxHGD1=wfR5Z03-bFjiZJ9EbAhimj8tqV7A@mail.gmail.com>
	<4109374.xIp3Nx6jlj@helios>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 23 Feb 2012 10:26:31 -0700
X-Google-Sender-Auth: 8X_y_4O1z5vCagsRuC3tBkJpAVE
Message-ID: <CABcZANmXmvz1uicVVoWqKa1QPGN72-=RzJAPX8UC4EQDC7cZSw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: fix parse errors not being reported
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
X-List-Received-Date: Thu, 23 Feb 2012 17:35:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 10:23 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Thursday 23 February 2012 09:14:16 Chris Larson wrote:
>> <paul.eggleton@linux.intel.com> wrote:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as exc:
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0etype, value, tb =3D sys.ex=
c_info()
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error('Unable to par=
se %s', value.recipe,
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 exc_info=3D(etype, value, exc.traceback))
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error('Error during =
parsing %s: %s\n%s' % (exc.recipe,
>> > str(exc), ''.join(bb.exceptions.format_extracted(exc.traceback,
>> > limit=3D5))))
>> This seems odd to me. Is the UI not displaying the traceback when sent
>> to it via the exc_info? Half the point of coming up with the new
>> traceback format which is pickleable was to allow us to do exception
>> formatting in the UI.
>
> Actually that's odd, I could have sworn when I tried this it broke, but i=
t
> seems to be doing the right thing now. Will send a v2 reverting this part=
.
>
> Presumably you are happy with the rest of it?

Yeah, looks fine to me, nice work.
--=20
Christopher Larson


