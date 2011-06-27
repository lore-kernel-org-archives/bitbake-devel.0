Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QbCVM-0004tj-Id
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Jun 2011 16:09:36 +0200
Received: by vxa37 with SMTP id 37so3713090vxa.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2011 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=8+IycNv45vKUaWeiEXMNce+yfTl1IiDtwr1mg6lslrg=;
	b=tcYSAxwx3Taqp5+8DRApvoHWI30Gz70+b4BkbMkQT58UVbFG35NLPJhbdwazDFvqxs
	qBboLhEnvRqMdbrMs8KhTGOqPuKv+7zIxIPkmU61Of1sDDD75wM0YJsYT7ik0fh+A5qS
	UO2nEehXasFPYf+om/5L2Lj2JIEuOkb3uvPgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	b=aa6GXNI5u20iTd160Ut60ako/xvfEgNCbNA1eo4FYC8fEepxINd5gRJcuuRiSzaaPg
	NHqUt4xOZpvTBA4iXXcdzd8sEJ5b0nljXzVKUgO+Y3Tvj0GE+j5TrQvtaKUl082BSjQ+
	A/m/6Dwxh8isX23HKqeHe9Qq6ov42yDyvVwS0=
Received: by 10.52.111.71 with SMTP id ig7mr8821076vdb.209.1309183556050; Mon,
	27 Jun 2011 07:05:56 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.181.2 with HTTP; Mon, 27 Jun 2011 07:05:36 -0700 (PDT)
In-Reply-To: <1309182577.20015.233.camel@rex>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
	<20110624183837.GI29476@denix.org> <1309182577.20015.233.camel@rex>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 27 Jun 2011 07:05:36 -0700
X-Google-Sender-Auth: LuXm67y4iyGm8CRD-nJtV3qgrQE
Message-ID: <BANLkTin4EJ8ekJpHqpLxnO9AxZJbAibP3g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Mon, 27 Jun 2011 14:09:36 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2011 at 6:49 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2011-06-24 at 14:38 -0400, Denys Dmytriyenko wrote:
>> On Fri, Jun 24, 2011 at 11:16:53AM -0700, Chris Larson wrote:
>> > On Mon, Jun 20, 2011 at 12:29 AM, Cui, Dexuan <dexuan.cui@intel.com> w=
rote:
>> > > Martin Jansa wrote:
>> > >> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui <dexuan.cui@intel.com>
>> > >> wrote:
>> > >>> This patch moves the logic of show_appends_with_no_recipes from
>> > >>> bitbake-layers into bitbake, and makes the script die with a fatal
>> > >>> error message printed.
>> > >>
>> > >> I agree that this is problem, but I'm not sure if it should be fata=
l.
>> > >>
>> > >> Imagine the case when you enable some layer managed by someone else
>> > >> (lets call it LS) and you're using different oe-core revision, mayb=
e
>> > >> current HEAD and that LS wasn't updated for that or vice versa you'=
re
>> > >> using some oe-core release version and you want to reuse some recip=
es
>> > >> from LS in current version.
>> > >>
>> > >> I think that big fat warning that some .bbappends does not match
>> > >> should be enough to decide if it's fatal for me (and I'll kill that
>> > >> build) or that's fine (when I'm not interested in those .bbappends
>> > >> from LS and I'm using only some other .bb files from LS).
>> > >>
>> > >> If we make it fatal then I would be forced to remove unmatched
>> > >> .bbappends from LS before build which can be difficult to share
>> > >> (unless I create own LS branch and use it in my distro).
>> > > Thanks a lot for the explanation!
>> > > So looks we may as well change the "bb.fatal" to "bb.error"(that is =
not
>> > > fatal and wouldn't be ignored by bitbake-layers).
>> > > This is the new patch (on a new branch dcui/bb-v2):
>> > > http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddcui=
/bb-v2&id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a
>> >
>> > Are you sure this shouldn't be a warning? Remember that any error
>> > displayed results in a non-zero exit code from bitbake.
>>
>> So, speaking of which - what is the practical use for bb.error? It gives=
 an
>> error message, but doesn't stop the build. Although it returns a non-zer=
o exit
>> code, which for most autobuilders indicate a failed build anyway... What=
's the
>> point?
>
> It denotes something which the user really needs to know about and fix.
> The sanity tests are good example and I'd really like to see sanity
> issues becoming bb.errors in most cases.
>
> You can also think about it as being a point on the error severity
> scale:
>
> Note: Information only
> Warning: Something happened which the user likely needs to fix
> Error: Something happened the user is strongly recommended to fix - set
> =C2=A0 =C2=A0 =C2=A0 exit code accordingly.
> Fatal: Something bad happened and there is no hope so stop.
>
> I think in the scheme of different error priorities and actions, it
> makes sense...

I really don't think they're very useful right now. If our UIs
actually captured the errors and summarized them at the end of the
build, as well as had them in a global log, then I could see them
being of use, but having an error message that might have scrolled
past an hour ago result in a non-zero exit code is far from ideal. As
a user, I have no idea why it seems to have failed.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


