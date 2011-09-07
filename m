Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1R1Pyq-0000yp-Pn
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 23:48:24 +0200
Received: by wwe32 with SMTP id 32so91668wwe.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Sep 2011 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=lehYslHDfMjwRHdJQ3qOYWNzs5GREin5vY4wlkFZh2k=;
	b=sOZozpP1NCvuNyjfowXZb48AtpCj0hdsUXvhTL9CMioltTVE4lHRYN3OjGv9vlp2zF
	1HdiKHL3/tod+3Yw4npHjW5FKu+IBEZvhtUzY5FK8fRH6ATDz21Rz7PMxzTPRmvi8H0L
	Dr6sOUgiOmtBwXiaGgIFd224HbxCcv7HgLS60=
Received: by 10.216.1.200 with SMTP id 50mr1982419wed.33.1315431802165; Wed,
	07 Sep 2011 14:43:22 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.93.70 with HTTP; Wed, 7 Sep 2011 14:43:02 -0700 (PDT)
In-Reply-To: <1315429879.13021.23.camel@ted>
References: <1315417400.13021.20.camel@ted>
	<CABcZANkp2JLJJ4G1J1dcRkNSqiEqWqnv5Qav-5F=EAzD0UxJ3w@mail.gmail.com>
	<1315429879.13021.23.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 7 Sep 2011 14:43:02 -0700
X-Google-Sender-Auth: wZPsKx-2fgaaATgpiZDAk42TB2A
Message-ID: <CABcZANk18Pf6ZR5Pe3rAK7Lo=87__8gPU2n9yCv3JdO_XeznVw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: runqueue: Ensure task environment is correct
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
X-List-Received-Date: Wed, 07 Sep 2011 21:48:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 7, 2011 at 2:11 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Wed, 2011-09-07 at 11:38 -0700, Chris Larson wrote:
>> On Wed, Sep 7, 2011 at 10:43 AM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> > This fixes two problems:
>> >
>> > a) Variables which were in the parent environment but not set as "expo=
rt"
>> > =C2=A0 variables in the datastore could end up in the task environment
>> >
>> > b) oe.environ.update() can't cope with the generator returned by
>> > =C2=A0 bb.data.exported_vars()
>> >
>> > Whilst the updated code isn't as neat, it does do the expected thing,
>> > sets the environment correctly and stops unwanted values leaking into
>> > the task environment.
>> >
>> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> >
>> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> > index 5a4321f..72e6845 100644
>> > --- a/bitbake/lib/bb/runqueue.py
>> > +++ b/bitbake/lib/bb/runqueue.py
>> > @@ -1136,7 +1136,12 @@ class RunQueueExecute:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for h in self.=
rqdata.hash_deps:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.environ.up=
date(bb.data.exported_vars(the_data))
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# exported_va=
rs() returns a generator which *cannot* be passed to os.environ.update()
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# successfull=
y. We also need to unset anything from the environment which shouldn't be t=
here
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exports =3D b=
b.data.exported_vars(the_data)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.empt=
y_environment()
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for e, v in e=
xports:
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0os.environ[e] =3D v
>>
>> os.environ.clear()
>> os.environ.update(bb.data.exported_vars(the_data))
>
> I tried this when testing and when I read os.environ back, it was not
> correct. There is something odd occurring if you pass the generator into
> update() directly.

Odd. It works fine in my local testing. Maybe there's a python bug
lurking -- I can't imagine it's supposed to work this way. Guess we
have to do it this way, but I really think you should consider
isolating the problem and reporting it upstream to the python project.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


