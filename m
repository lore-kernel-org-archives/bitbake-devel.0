Subject: Re: [PATCH] cooker: Only warn on potentially incompatible layer
To: bitbake-devel@lists.openembedded.org
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
X-Originating-Location: Imielin, Silesia, PL (178.217.216.129)
X-Originating-Platform: Linux Firefox 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 03 Sep 2021 10:53:58 -0700
References: <b23f250a23dbd3273392b6694a442f5bb5602bf7.camel@linuxfoundation.org>
In-Reply-To: <b23f250a23dbd3273392b6694a442f5bb5602bf7.camel@linuxfoundation.org>
Message-ID: <22175.1630691638780132694@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="X2ZvPsTW6aAhXFOrRWnX"

--X2ZvPsTW6aAhXFOrRWnX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 3, 2021 at 07:07 PM, Richard Purdie wrote:

>=20
> LAYERSERIES_COMPAT

The problem is that there is inconsistency for treating layers with and wit=
hout LAYERSERIES_COMPAT.

If the layer without LAYERSERIES_COMPAT works perfectly - only a warning is=
 emitted. Then
symmetrically the same should happen for a layer with LAYERSERIES_COMPAT - =
especially that
this check is not able to detect any real problems in this layer - it only =
blindly rejects a valid layer.

Additionally, this bb.fatal generates compatibility problem as we're able t=
o consume 3rd party
layers which have LAYERSERIES_COMPAT in yocto morty (which doesn't use this=
 compatibility check),
but the same layers are false positively rejected by yocto dunfell.

Having this merged would allow to limit maintenance burden on 3rd party lay=
ers.

--
Regards,
Damian

--X2ZvPsTW6aAhXFOrRWnX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 3, 2021 at 07:07 PM, Richard Purdie wrote:<br />
<blockquote>LAYERSERIES_COMPAT</blockquote>
The problem is that there is inconsistency for treating layers with and wit=
hout LAYERSERIES_COMPAT.<br /><br />If the layer without LAYERSERIES_COMPAT=
 works perfectly - only a warning is emitted. Then<br />symmetrically the s=
ame should happen for a layer with LAYERSERIES_COMPAT - especially that<br =
/>this check is not able to detect any real problems in this layer - it onl=
y blindly rejects a valid layer.<br /><br />Additionally, this bb.fatal gen=
erates compatibility problem as we're able to consume 3rd party<br />layers=
 which have LAYERSERIES_COMPAT in yocto morty (which doesn't use this compa=
tibility check),<br />but the same layers are false positively rejected by =
yocto dunfell.<br /><br />Having this merged would allow to limit maintenan=
ce burden on 3rd party layers.<br /><br />--<br />Regards,<br />Damian

--X2ZvPsTW6aAhXFOrRWnX--
