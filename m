Return-Path: <anibal.limon@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 26CEA71B07
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:43:43 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP; 14 Oct 2016 08:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,493,1473145200"; 
	d="asc'?scan'208";a="20062410"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.32]) ([10.219.5.32])
	by orsmga004.jf.intel.com with ESMTP; 14 Oct 2016 08:43:43 -0700
To: ed.bartosh@linux.intel.com
References: <1476400294-17333-1-git-send-email-anibal.limon@linux.intel.com>
	<20161014084408.GA392@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <5800FD6F.2080103@linux.intel.com>
Date: Fri, 14 Oct 2016 10:44:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20161014084408.GA392@linux.intel.com>
Cc: benjamin.esquivel@intel.com, brian.avery@intel.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.event: fix infinite loop on print_ui_queue
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
X-List-Received-Date: Fri, 14 Oct 2016 15:43:44 -0000
X-Groupsio-MsgNum: 8134
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="p92pb4a75uRc4I7XAou0ucmQiofTtSsim"

--p92pb4a75uRc4I7XAou0ucmQiofTtSsim
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/14/2016 03:44 AM, Ed Bartosh wrote:
> On Thu, Oct 13, 2016 at 06:11:34PM -0500, An=EDbal Lim=F3n wrote:
>> If bitbake ends before _uiready and bb.event.LogHandler was add
>> to the bitbake logger it causes an infinite loop when logging
>> something.
>>
>> The scenario is print_ui_queue is called at exit and executes
>> the log handlers [2] one of them is bb.event.LogHandler this handler
>> appends the same entry to ui_queue causing the inifine loop [3].
>>
>> In order to fix we need to keep track of events already handled to
>> avoid the infinite loop.
>>
>> [YOCTO #10399]
>>
>> [1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10399#c0
>> [2] http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=3D41d9=
cd41d40b04746c82b4a940dca47df02514fc#n156
>> [3]
>> http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=3D41d9cd41=
d40b04746c82b4a940dca47df02514fc#n164
>>
>> Signed-off-by: An=EDbal Lim=F3n <anibal.limon@linux.intel.com>
>> ---
>>  lib/bb/event.py | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/lib/bb/event.py b/lib/bb/event.py
>> index c5a5f94..8464e06 100644
>> --- a/lib/bb/event.py
>> +++ b/lib/bb/event.py
>> @@ -139,7 +139,11 @@ def print_ui_queue():
>> =20
>>          # First check to see if we have any proper messages
>>          msgprint =3D False
>> +        events_handled =3D []
>>          for event in ui_queue:
>> +            if event in events_handled:
>> +                continue
>> +
>>              if isinstance(event, logging.LogRecord):
>>                  if event.levelno > logging.DEBUG:
>>                      if event.levelno >=3D logging.WARNING:
>> @@ -148,14 +152,20 @@ def print_ui_queue():
>>                          logger.addHandler(stdout)
>>                      logger.handle(event)
>>                      msgprint =3D True
>> +            events_handled.append(event)
>>          if msgprint:
>>              return
>> =20
>>          # Nope, so just print all of the messages we have (including =
debug messages)
>>          logger.addHandler(stdout)
>> +        events_handled =3D []
>>          for event in ui_queue:
>> +            if event in events_handled:
>> +                continue
>> +
>>              if isinstance(event, logging.LogRecord):
>>                  logger.handle(event)
>> +            events_handled.append(event)
>> =20
>>  def fire_ui_handlers(event, d):
>>      global _thread_lock
>=20
> Would using full slice of ui_queue work the same way?

Yes it will work and is more simple, i'll send v2.

	alimon

>=20
> @@ -139,7 +139,7 @@ def print_ui_queue():
>=20
>          # First check to see if we have any proper messages
>          msgprint =3D False
> -        for event in ui_queue:
> +        for event in ui_queue[:]:
>              if isinstance(event, logging.LogRecord):
>                  if event.levelno > logging.DEBUG:
>                      if event.levelno >=3D logging.WARNING:
>=20
>=20
> --
> Regards,
> Ed
>=20


--p92pb4a75uRc4I7XAou0ucmQiofTtSsim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYAP12AAoJEGJqcE9h3glgaaMQAImfdmMenj9dYKzF+rcnbm4I
g/Ot/77zNiUtdNEHRyC2TSW1iaR2m7gt4J9NT+k1pyB+8g6qeyiK/zRWcE2sxUww
BtoOzPmSiFrdpJLMY9cV8JL7eJXyVYZndzuQmRD61SphAgpbIEEhcnKqcXFecrj5
Ze13b2WOtCVtrciGSLwO++0p7IOiz/iceabwPN0b6KlWAtb66R+4dRF2vVf1VE64
mlJlywIWnHEtPOJBk4GuQgHMNkdbNkqyLFI3VOHPBAntypi56YSnhO8CTEuiTId0
kaWi0frdgcIYKCoZiHKuXjukQrNJq76eONhK2nL3dNcPAchkhlyuk0/DHQb3yCUu
wl+66a/xR0I5aHamm4wn0Y/SlSbAYV7eOIfL+S6XO42kOVrSV00J1kHz+0PKcQw4
FBTpS8+yfXPsADEjf/lK20j5qT0UKdEE35wG0IxY/dRzuANS9rzbQy+PqjImTR0i
kGKUne7CdOMc4Y67JCMXdbaaQvpjzmPIgBDDeGbFwbQbAAVbIsQ3pa5XxYU2yB1T
VRDt6opL+HoC3uWKf3xRbUjf58mI578TvVmgEvbv7KaN9Eo0hAXYg4DkmDrBlVdI
WfR/o7yzOaiVxfdATLpA4s9xaiEK35fIHNl8RgP6OpSDflikeyJD4B+5umItC0CB
egXgHRbOXOP0aU09j5Bh
=pqeG
-----END PGP SIGNATURE-----

--p92pb4a75uRc4I7XAou0ucmQiofTtSsim--
