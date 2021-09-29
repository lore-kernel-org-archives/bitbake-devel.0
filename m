Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1BFC433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 16:55:45 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web09.172.1632934544354835900
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Sep 2021 09:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([70.99.78.137])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18TGtgII030612
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 11:55:43 -0500
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Show error for no BBLAYERS in
 bblayers.conf
To: bitbake-devel@lists.openembedded.org
References: <20210910142719.1257009-1-richard.purdie@linuxfoundation.org>
 <20210910142719.1257009-2-richard.purdie@linuxfoundation.org>
 <b299a244-31f1-30fb-3fe0-3ade94815697@windriver.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <d183aadd-3904-2faa-238f-ffffd28722f4@kernel.crashing.org>
Date: Wed, 29 Sep 2021 11:55:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b299a244-31f1-30fb-3fe0-3ade94815697@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id
 18TGtgII030612
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 16:55:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12717



On 9/27/21 3:58 AM, Changqing Li wrote:
> Hi, Richard
>=20
> This patch cause one problem for layerindex.
>=20
> function init_parser in
> http://git.yoctoproject.org/cgit.cgi/layerindex-web/tree/layerindex/rec=
ipeparse.py,=C2=A0
>=20
> will setup tinfoil in an temp dir without setting BBLAYERS . This patch=
 will
> make layerindex update failed since setup tinfoil failed.

Does the temp dir need this configured?  I believe other parts of the par=
sing we
do configure things to work with specific default variable definitions.
Defining the branch/release we're looking for seems like the right answer=
 here.

> layerindex setup tinfoil for parsing current target-layer's layer.conf,=
 so don't
> need to set BBLAYERS.=C2=A0
>=20
> Can we revert this or just report as warning?

It really should be a error.  I've ended up accidently doing this before =
and
it's really painful to debug.

I could see some of the other utilities thought failing here (bitbake-tes=
ts or
even bitbake-layers in some cases.)

So I think it's a setup issue within the scope of the layer index parser.=
  It
might be enough to set the name in a variable in the 'if not classic' cas=
e to
simulate a properly configured machine.  (i.e. BBLAYERS =3D " " or genera=
te a
dummy layer that does nothing and include it.)

--Mark

> Thanks
>=20
> Changqing
>=20
> ||
> On 9/10/21 10:27 PM, Richard Purdie wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> If there is no BBLAYERS set in bblayers.conf show a more helpful
>> error and exit.
>>
>> [YOCTO #14340]
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>>  lib/bb/cookerdata.py | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
>> index e54858cf02..d6206b7319 100644
>> --- a/lib/bb/cookerdata.py
>> +++ b/lib/bb/cookerdata.py
>> @@ -342,6 +342,9 @@ class CookerDataBuilder(object):
>>              layers =3D (data.getVar('BBLAYERS') or "").split()
>>              broken_layers =3D []
>>
>> +            if not layers:
>> +                bb.fatal("The bblayers.conf file doesn't contain any =
BBLAYERS definition")
>> +
>>              data =3D bb.data.createCopy(data)
>>              approved =3D bb.utils.approved_variables()
>>
>> --
>> 2.32.0
>>
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12709): https://lists.openembedded.org/g/bitbake-de=
vel/message/12709
> Mute This Topic: https://lists.openembedded.org/mt/85510606/3616948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mark=
.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

