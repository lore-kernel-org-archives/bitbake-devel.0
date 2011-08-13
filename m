Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Qs1j7-0007tf-BU
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 02:05:21 +0200
Received: by vxj14 with SMTP id 14so3089366vxj.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=06aw2vNWcnbkOveoD95hXJPbqtNgy3e+2KUIwOYvNAw=;
	b=Ye04iAcI958XQuEg5g/S4e+TBUsBnZAboEu8ucRib7Itqg3Cn1hRt+S6arauvSNq9z
	sG5UYvOYfl+E0JdeUXssIcteIto+3b90Oo8TbohcrGCnw5YlpZhr7o9eJMsBCfsd6Dsw
	LWbvJvoxYnB0TZ7qkBG9gPrOp8uMC4zAmIyxI=
Received: by 10.52.20.228 with SMTP id q4mr645vde.498.1313193647092; Fri, 12
	Aug 2011 17:00:47 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Fri, 12 Aug 2011 17:00:27 -0700 (PDT)
In-Reply-To: <1313192525.2228.8.camel@scimitar>
References: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
	<1313191795.2228.6.camel@scimitar>
	<CABcZANki4ULpVxRYM9EPA05ZEWHY6g+Fnr_0ntQDjKPcZ_WSnQ@mail.gmail.com>
	<1313192525.2228.8.camel@scimitar>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 12 Aug 2011 17:00:27 -0700
X-Google-Sender-Auth: 2A8T79n75SbCCOIPLoc0iJQBAiM
Message-ID: <CABcZAN=VxGeq-A1et46xPYRDGUxAQgOo3vkX05VCghu_nDk0hw@mail.gmail.com>
To: Joshua Lock <josh@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditional assignment broken
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
X-List-Received-Date: Sat, 13 Aug 2011 00:05:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 4:42 PM, Joshua Lock <josh@linux.intel.com> wrote:
> On Fri, 2011-08-12 at 16:32 -0700, Chris Larson wrote:
>> On Fri, Aug 12, 2011 at 4:29 PM, Joshua Lock <josh@linux.intel.com> wrot=
e:
>> > On Sat, 2011-08-13 at 06:50 +0800, James Limbouris wrote:
>> >> Hi,
>> >>
>> >> =C2=A0Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditio=
nal assignment
>> >> =C2=A0in all conf files. Previously, the environment was copied from =
a
>> >> cleaned up os environment.
>> >> =C2=A0After the commit, a pristine environment is available in
>> >> data['_data'], and will be copied to
>> >> =C2=A0data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
>> >> Variables not conditionally
>> >> =C2=A0assigned will still be available from data['_data'], also in de=
fiance
>> >> of BB_ENV_EXTRAWHITE.
>> >>
>> >> =C2=A0To verify, simply:
>> >>
>> >> =C2=A0export RANDOMENV=3D42
>> >> =C2=A0bitbake -e | grep RANDOMENV
>> >
>> > Thanks for the report James, and apologies for the breakage. I'll try
>> > and get a fix submitted and merged asap.
>> >
>> > I'm now wondering if we want the pristine environment, or the cleaned
>> > environment, saved.
>>
>> For things like devshell, I think it would be nice to retain a copy of
>> the original, unmodified environment.
>
> Agreed, that was one of the intended consumers. I guess I need to drink
> more coffee and figure out the *right* fix then...

You could pass the key list from the filtered env along with the
unfiltered dict to inheritFromOS, rather than using all the keys from
the unfiltered env, I would think.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


