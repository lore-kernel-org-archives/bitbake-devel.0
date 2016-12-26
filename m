Return-Path: <philip@balister.org>
X-Greylist: delayed 401 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 26 Dec 2016 17:18:52 UTC
Received: from sanddollar.geekisp.com (sanddollar.geekisp.com
	[216.168.135.167])
	by mail.openembedded.org (Postfix) with ESMTP id 2266860069
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Dec 2016 17:18:52 +0000 (UTC)
Received: (qmail 12090 invoked by uid 1003); 26 Dec 2016 17:12:13 -0000
Received: from unknown (HELO ?10.0.0.98?) (philip@opensdr.com@73.148.15.238)
	by mail.geekisp.com with (DHE-RSA-AES128-SHA encrypted) SMTP;
	26 Dec 2016 17:12:13 -0000
To: openembedded-devel@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	yocto-infrastructure@yoctoproject.org, yocto@yoctoproject.org
References: <CAHQecY48gVbt4S+88MHivSbv-Xdn29WRq5RPL6+QDVGYUPCwYw@mail.gmail.com>
	<E628426E-84F8-4EA4-A296-D32C3339DF1C@gmail.com>
	<CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
	<74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
From: Philip Balister <philip@balister.org>
Message-ID: <c3f72389-1727-a279-1cfc-1341ffacdb37@balister.org>
Date: Mon, 26 Dec 2016 12:12:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
Subject: Re: [oe] Infra Full Stop 12/26-12/29
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
X-List-Received-Date: Mon, 26 Dec 2016 17:18:54 -0000
X-Groupsio-MsgNum: 8323
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NPtPn8wNJQG4VRRUpR4F0vqVsnIX6t6iI"

--NPtPn8wNJQG4VRRUpR4F0vqVsnIX6t6iI
Content-Type: multipart/mixed; boundary="FLsfQnga6UCU70XIFHIGwxGQHT5i9GC06";
 protected-headers="v1"
From: Philip Balister <philip@balister.org>
To: openembedded-devel@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org, yocto-infrastructure@yoctoproject.org,
 yocto@yoctoproject.org
Message-ID: <c3f72389-1727-a279-1cfc-1341ffacdb37@balister.org>
Subject: Re: [oe] Infra Full Stop 12/26-12/29
References: <CAHQecY48gVbt4S+88MHivSbv-Xdn29WRq5RPL6+QDVGYUPCwYw@mail.gmail.com>
 <E628426E-84F8-4EA4-A296-D32C3339DF1C@gmail.com>
 <CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
 <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
In-Reply-To: <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>

--FLsfQnga6UCU70XIFHIGwxGQHT5i9GC06
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/25/2016 11:06 PM, Michael Halstead wrote:
> In preparation for the scheduled maintenance I have moved
> git.openembedded.org to a new server temporarily. E-mail and Patchwork
> hooks may not work correctly. All other git operations as well as
> listings at http://git.openembedded.org/ should continue working.
>=20
> If you have a git remote pointed directly at openembedded.org it will
> fail. Please update your remote to point at git.openembedded.org and tr=
y
> again.
>=20
> Other services that will stay up during the maintenance are:
>=20
> Layerindex https://layers.openembedded.org/
> Mailman http://lists.openembedded.org/
> Patchwork https://patchwork.openembedded.org/
>=20
> I'd like the share my appreciation for the OpenEmbedded volunteer
> sysadmins who are taking time away from their holiday celebrations to
> make this downtime as convenient for the rest of us as possible.

I'd like to thank everyone working on this project for their hard work
through out the year keeping OpenEmbeded up to date and moving it
forward as the premier embedded Linux (and possibly other OS') build syst=
em.

Here's to a good New Year!

Philip

>=20
>=20
> On 12/22/2016 09:19 AM, Tom King wrote:
>> Schedule is  06:00UTC 27DEC16 for the full stop.  Things will start co=
ming
>> back (estimated) about 48hrs later.
>>
>> Tom
>>
>> On Tue, Dec 20, 2016 at 11:16 AM, Khem Raj <raj.khem@gmail.com> wrote:=

>>
>>>> On Dec 20, 2016, at 10:50 AM, Tom King <ka6sox@gmail.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> We have been looking for a time when we could do a full stop of the =
infra
>>>> to upgrade some bits and clear out some faults.
>>>>
>>>> This will involve shutting down the main machine that we use for *mo=
st*
>>> of
>>>> the OE infra.
>>>>
>>>> Our goal is to put up a backup git master but other services such as=
:
>>> wiki,
>>>> patches, etc will be offline for some or all of that period.
>>>>
>>>> We have delayed doing this much needed maintenance to try to work ar=
ound
>>>> Yocto and OE release schedules and it is necessary that we take this=
 time
>>>> to do the work.
>>>>
>>> I guess, you need to come up with a tentative down-time schedule.
>>>
>>>> Tom
>>>> (for the OE Infra Team)
>>>> --
>>>> _______________________________________________
>>>> Openembedded-devel mailing list
>>>> Openembedded-devel@lists.openembedded.org
>>>> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
>>> --
>>> _______________________________________________
>>> Openembedded-devel mailing list
>>> Openembedded-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
>>>
>=20
>=20
>=20


--FLsfQnga6UCU70XIFHIGwxGQHT5i9GC06--

--NPtPn8wNJQG4VRRUpR4F0vqVsnIX6t6iI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQExBAEBCAAbBQJYYU9sFBxwaGlsaXBAYmFsaXN0ZXIub3JnAAoJEMDJd4rr0mer
SOkIAIpMnJJ8yaDiGjXchoZXWlCRxkvg1eoFRGGX93CNnJKfv+tCpXZP6A2U0dx4
2sb7BpmDSelIVZ6k32Dek/tzd3OpVjo71tVuod6MoBRZI1sla1mSeT+zc5luSYor
/Wp+3qxTrBlxB3oYxYPy/UT/WdDuQbn62pm0ZOtu35WVa9oZsmcGCH17hNmtz4Tw
kCWMl/KkLZdayJAMFR7MKs8owmslyWzMsG+4c4kR3i6ZQJN5yPl07L9x6uW/H4Ig
kEEr3XG+NsWa9SHxN4gpmT+NW1jL4Qv8GndpRmgXRlAgf0rHC9Pgrg8McqHpJ0bB
0k5upfGJyPsNq/yPFVkB38FBc6w=
=pryV
-----END PGP SIGNATURE-----

--NPtPn8wNJQG4VRRUpR4F0vqVsnIX6t6iI--
