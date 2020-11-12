Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.8146.1605202943967127610
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2020 09:42:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=WJTQeqLm;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2264; q=dns/txt; s=axis-central1;
  t=1605202944; x=1636738944;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kdkzDWc0QKGhLdDxxloFHCzVfG/tyvhZN2jLTkiUjmE=;
  b=WJTQeqLmwmt51eB2QqlVQjutYqFaCX8sNtZX5JRDopkORauAaNIVgeor
   IwbMa3tr9Xerj1O6+e9jGlWeHVLq4Ztr1wDEXk3l4ryLtfmRL2RAenPpt
   cnyPwGIPmi5dd2P6IhpgQ634PChCbM4WGtzw+39jsSZI8ixR2y8Oikc1g
   twpIQAURwvnzyJaHPUU3hchGOYOIYNswt5/sccc3/bu7pS/HAk2wVMAdS
   415QsJywJc+Vh9m+l1pQWQMAbncGhGTiuQ/pf+DNEaD1TeC1Xen6TVBJw
   p7TNafPmsGDFzclGFqmEr2J/NWytUPiqKp5+m/fwDsLlh96DCqUIChNs/
   A==;
IronPort-SDR: B9OPIuCdObK62MBO39Q0cgS4ZNooTkLi34U9wQHal/cD61PBC+ioAP2wHrss97U0iu8GwjhbdB
 FcaEoQ+kKRd3ljrZvOmHGjEDfkq21IC4frjVIVnlP+am8hh5sbP/Wvf8QCW1A36iOoDydnkvmF
 yexBkl6261ilXLpAyfyfW9Ikqtjc6MpYPmW1g2dPX9+gkAbvs7+E1UFc93g2phwB6zdnSqTN3a
 fWaB2oq3+Q37T+PF5VICTUFHIsuyMSjNTJLYytE0gwBZ7HlqmEZxVKIQFaeEvAYAeQsa/EWQeJ
 rcQ=
X-IronPort-AV: E=Sophos;i="5.77,472,1596492000"; 
   d="scan'208";a="15005227"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Lee Chee Yang <chee.yang.lee@intel.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] BBHandler: prompt error when task name contain expression
Thread-Topic: [bitbake-devel] [PATCH] BBHandler: prompt error when task name
 contain expression
Thread-Index: AQHWsw7sloBQBrTZq0GEOWe3nd5uwqnEzUlQ
Date: Thu, 12 Nov 2020 17:42:20 +0000
Message-ID: <161971e200fd400d876ba64b7e25b31e@XBOX03.axis.com>
References: <20201105005921.56640-1-chee.yang.lee@intel.com>
In-Reply-To: <20201105005921.56640-1-chee.yang.lee@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Lee Chee Yang
> Sent: den 5 november 2020 01:59
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] BBHandler: prompt error when task name c=
ontain expression

Change "contain" to "contains".

>=20
> From: Lee Chee Yang <chee.yang.lee@intel.com>
>=20
> Task name contain expresion (eg, do_foo_remove_bar) can cause fatal

Change "Task name contain expresion" to "A task name that contains an expre=
ssion",=20
and "fatal" to "a fatal".

> error.
>=20
> Check for naming before addtask. Prompt with understandable error message
> when expression found in task name.
>=20
> [YOCTO #8805]
>=20
> Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
> ---
>  lib/bb/parse/parse_py/BBHandler.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/B=
BHandler.py
> index 215f940b..dd9a92b4 100644
> --- a/lib/bb/parse/parse_py/BBHandler.py
> +++ b/lib/bb/parse/parse_py/BBHandler.py
> @@ -13,7 +13,7 @@
>  #
>=20
>  import re, bb, os
> -import bb.build, bb.utils
> +import bb.build, bb.utils, bb.data_smart
>=20
>  from . import ConfHandler
>  from .. import resolve_file, ast, logger, ParseError
> @@ -233,6 +233,10 @@ def feeder(lineno, s, fn, root, statements,
> eof=3DFalse):
>              if taskexpression.count(word) > 1:
>                  logger.warning("addtask contained multiple '%s' keywords=
, only one is supported" % word)
>=20
> +        # Check and warn for having task with exprssion as part of task =
name

Change "exprssion" to "expression".

> +        for te in taskexpression:
> +            if any( ( "%s_" % keyword ) in te for keyword in bb.data_sma=
rt.__setvar_keyword__ ):
> +                raise ParseError("Task name '%s' contain expression keyw=
ord, this is confusing the parser.\nAvoid using these expression keyword in=
 task name.\n%s" % (te, ("\n".join(map(str, bb.data_smart.__setvar_keyword_=
_)))), fn)

Change "contain" to "contains an" and "keyword in task name." to "keywords =
in task names:".

>          ast.handleAddTask(statements, fn, lineno, m)
>          return
>=20
> --
> 2.17.1

//Peter

