Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 431 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 07 Feb 2020 16:09:19 UTC
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 7C34E60D3B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Feb 2020 16:09:19 +0000 (UTC)
IronPort-SDR: VJAD0zwzw1+eazAiBFRZdQbOXUM1GccX+7NPbNv68tXE9YZglEV1Q3ByeU9cAo+MRFEDyAr8G6
	TjWQNefs7aHF1IWygvc+LRi0kD/XrFMn2HPgnnvtyrw5zDbisNSls776vrlCy1+2/+0/iKHyHs
	qnHY2EaQ01i5w56Pl1I2er8qZ1joG3lq+NIsgj0B9G+aLBBqV3W4Bug4hYaWEkLtwUzRR3lxkD
	BEB2C8z3942SovC5NHJMRF5UZ8rqTP4ZVIw/PXvu0YA8yF4tbc4Q+LrEnSRHnhRMFaD/k+pwxW
	LYA=
X-IronPort-AV: E=Sophos;i="5.70,413,1574118000"; 
   d="scan'208";a="5051703"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] doc: Explain dynamic calculation of
	BB_NUMBER_THREADS
Thread-Index: AQHV3ZxMjLUZI4fv2E+VrtM7bmS1YagP5CUA
Date: Fri, 7 Feb 2020 16:02:07 +0000
Message-ID: <f49911799c7c4ab6a61e2293a5707560@XBOX03.axis.com>
References: <alpine.LFD.2.21.2002070449140.2057256@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2002070449140.2057256@localhost.localdomain>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH] doc: Explain dynamic calculation of	BB_NUMBER_THREADS
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
X-List-Received-Date: Fri, 07 Feb 2020 16:09:19 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> Sent: den 7 februari 2020 10:52
> To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> Subject: [bitbake-devel] [PATCH] doc: Explain dynamic calculation of
> BB_NUMBER_THREADS
>=20
>=20
> While it's useful for the reader to know about BB_NUMBER_THREADS, make
> it clear that that value will be calculated automatically by default.
>=20
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>=20
> ---
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/=
doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> index 46dafeee..f22ab36e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> @@ -53,6 +53,15 @@
>                  A possibly simpler solution is that some Linux distribut=
ions
>                  (e.g. Debian and Ubuntu) provide the <filename>ncpus</fi=
lename> command.
>              </para>
> +
> +	    <para>
> +		If you don't explicitly set this variable, OpenEmbedded
> +		will do it for you via the default <filename>bitbake.conf</filename>
> +		file by running an OE-supplied utility routine:
> +		<literallayout class=3D'monospaced'>
> +     BB_NUMBER_THREADS ?=3D "${@oe.utils.cpu_count()}"
> +		</literallayout>
> +	    </para>
>          </note>
>      </para>
>=20
> @@ -569,7 +578,8 @@
>=20
>          <para>
>              It is worth noting that you can greatly speed up the build t=
ime by properly setting
> -            the <filename>BB_NUMBER_THREADS</filename> variable.
> +            the <filename>BB_NUMBER_THREADS</filename> variable although=
, if you don't,
> +	    its value will be determined dynamically by an OpenEmbedded utility=
 routine.
>          </para>
>=20
>          <para>
>=20
> --

Since this is the BitBake manual, I do not think it is appropriate to=20
refer to OE specific behavior here.

//Peter


