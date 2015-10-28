Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id DE91475894
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Oct 2015 00:14:18 +0000 (UTC)
Received: by igbdj2 with SMTP id dj2so91007934igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=oqi6wNyRrCwVWoUN3tnTiB8kNjPxJ4zDIbRWA13nluo=;
	b=cAlbPy2CjbRySzQBP46rRfLF+GMqlm5I6aMnmHWLADw3yJ/eGPJ//M6+n8gQ2U1Ww1
	ZTHF+P+5UXhuDle+Ff3mmCsscaqXjUXKYr+ddtnHr7jIpOCa6gDA6ynXc/ywe6+pYQFr
	+fYmg1da7vn9jcC123g1JmHjKG0B/TjqJE6uPs2KpkbIMo9qT+9J9EhqF3SHTMHqSSLl
	VPPIadOz/MpzFA85+zFRQGKhbSnnRhRT6+U35bedAdfD4sTwTdqLSDn3A1pZoc8LCGTp
	kgC+IGFjjxwT/KdhpGPFS3dG9YLIaCdkls2cUPGVHmGv3oUvRILBu7+fQ0FHZpbXY4rt
	hyfg==
MIME-Version: 1.0
X-Received: by 10.50.50.137 with SMTP id c9mr27145809igo.23.1445991258415;
	Tue, 27 Oct 2015 17:14:18 -0700 (PDT)
Received: by 10.64.221.74 with HTTP; Tue, 27 Oct 2015 17:14:18 -0700 (PDT)
In-Reply-To: <32134538.nEPZhokZdl@peggleto-mobl.ger.corp.intel.com>
References: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
	<CAKV_0egMyNQ2bzbO+gydU+vDsc_xwGgKgwmh9YW8vynVhShQ8Q@mail.gmail.com>
	<40CEB3B1-8820-4D38-91B6-5A41DACC4AED@gmail.com>
	<32134538.nEPZhokZdl@peggleto-mobl.ger.corp.intel.com>
Date: Tue, 27 Oct 2015 17:14:18 -0700
Message-ID: <CAKV_0ej8G-z4U_g=gA4vzJd0vdOKwPCjnZp_ug57UMsZ00AXug@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: Point to meta/conf for default toasterconf.json
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
X-List-Received-Date: Wed, 28 Oct 2015 00:14:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

So,

"which is pretty much exactly the wrong thing to have done :/"

is my fault :(, mostly due to my lack of understanding of all the
pieces in play.

Having talked to RP this morning, to get some background, I think
Paul/RP (who had the same idea roughly) is to handle it the same way
we do the local.conf.sample in meta-yocto/conf.

Essentially, we would default to meta/conf/toasterconf.json and use
the TEMPLATECONF (which for yocto hides in poky/.templateconf) to
point the yocto toaster to the meta-yocto/conf/toasterconf.json
version).

Reply if this is ok w/ ya'll as a solution and I'll send a patch doing
that . I'd like to make sure I'm not stubbing anymore toes first,
though.

-b




On Tue, Oct 27, 2015 at 1:43 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Monday 26 October 2015 09:19:02 Khem Raj wrote:
>> > On Oct 26, 2015, at 9:05 AM, Brian Avery <avery.brian@gmail.com> wrote=
:
>> >
>> > True,
>> >
>> > but then builds for poky would fail :(
>> >
>> > How about something like (posted from gmail so just for discussion not
>> > to be used!!):
>> >
>> > if [ "$TOASTER_CONF" =3D "" ]; then
>> >
>> > -    TOASTER_CONF=3D"$(dirname
>> > $TOASTER)/../../meta-yocto/conf/toasterconf.json"
>> >
>> > +    if [ -e "$(dirname
>> > $TOASTER)/../../meta-yocto/conf/toasterconf.json" ] ; then
>> >
>> > +       TOASTER_CONF=3D"$(dirname
>> > $TOASTER)/../../meta-yocto/conf/toasterconf.json"
>> >
>> > +    elif [ -e "$(dirname $TOASTER)/../../meta/conf/toasterconf.json" =
] ;
>> > then
>> >
>> > +       TOASTER_CONF=3D"$(dirname
>> > $TOASTER)/../../meta/conf/toasterconf.json"
>> >
>> > +    fi
>> >
>> >     export TOASTER_CONF=3D$(python -c "import os; print
>> >
>> > os.path.realpath('$TOASTER_CONF')=E2=80=9D)
>>
>> I think checking meta-yocto and meta is just doing it for two distro=E2=
=80=99s
>> IMO OE-Core should just default to meta/ and meta-yocto/poky should then
>> set TOASTER_CONF in its distro.conf
>
> The original design that I specified was to check every layer in the
> configuration. Somehow what got implemented was to hardcode the path in b=
itbake
> which is pretty much exactly the wrong thing to have done :/
>
> If we're able to rely on DISTRO being set to the right thing then I'd go =
with
> Khem's approach, but the important thing to note is that this json file i=
s
> simply initialising the database; changing that path afterwards is going =
to do
> absolutely nothing. It's more akin to TEMPLATECONF (and possibly even hig=
her
> level than that, since you're likely to create new build directories more
> often than you'll create a new toaster database). Maybe we could use
> TEMPLATECONF?
>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre

