Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE12C433FE
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:17 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.240.1649191482165896704
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 13:44:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=cMUshv5u;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649191482;
  x=1680727482;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=30/JmiMyl6WeyG4hdk8mWA1tX24zzG5EnyYN5siEzlg=;
  b=cMUshv5u0rH7T9a6hbeKVnovfQwpZWlFyRtskjFsrZaexdKW/Sgf/27+
   G8A1OAK+0DwUlgkd+hNtQ8zvoVh/P8z4xOuXVWnFw5uS/SXHsEJLXuSf8
   I2EBIdeDE7D8VBg2nAXxpf8qBpDIsZUgZFmHnsnzPF8rdRegpAiCtuaFg
   zWsn6tEOYqFVKy/pAXyHw8mLPeauynNSnihHmzrUsJ8lQITw/57aMjPju
   JJ/U/deUAWyMKxQizuqlLMYNJyhku4LWNIoryHwVQy3BrlP9B9/He5gHx
   dak2PQM/YTSCjVaAa8xaaw2O2JKWxlJJT8gtY2d+6cVGlredzX/NMZPrz
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Abongwa Amahnui Bonalais <abongwabonalais@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] Added double quotes aound variables in
 bitbake/source to prevent gobbling or splitting
Thread-Topic: [bitbake-devel] [PATCH] Added double quotes aound variables in
 bitbake/source to prevent gobbling or splitting
Thread-Index: AQHYSRsloGD2ZCzhv0yXWz39wrTdGKzhxFXQ
Date: Tue, 5 Apr 2022 20:44:39 +0000
Message-ID: <237e1a6948d941969ef07f147be1aba1@axis.com>
References: <20220405182906.57588-1-abongwabonalais@gmail.com>
In-Reply-To: <20220405182906.57588-1-abongwabonalais@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Apr 2022 16:33:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13588

[ Since you seem new to the process of reviewing via mail, please=20
  note that I have added comments throughout the entire patch below. ]

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Abongwa Amahnui Bonalais
> Sent: den 5 april 2022 20:29
> To: bitbake-devel@lists.openembedded.org
> Cc: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
> Subject: [bitbake-devel] [PATCH] Added double quotes aound variables in b=
itbake/source to prevent gobbling or splitting

Always prefix the subject line with the affected recipe name or similar.=20
Also keep the subject short, typically shorter than 72 characters.
A better subject in this case would be:

  toaster: Add quoting of variables to avoid splitting

Then there should be a description that gives a motivation for=20
why this is needed and any other relevant information.

>=20
> Signed-off-by: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
> ---
>  bitbake/bin/toaster | 65 +++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
>=20
> diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
> index 558a819570..d98c4c69f0 100755
> --- a/bitbake/bin/toaster
> +++ b/bitbake/bin/toaster
> @@ -1,4 +1,5 @@
> -#!/bin/echo ERROR: This script needs to be sourced. Please run as .
> +#!/bin/sh
> +echo ERROR: This script needs to be sourced. Please run as .

Leave as it was. It is explicitly _not_ using #!/bin/sh as shebang line=20
to catch misuse.

>=20
>  # toaster - shell script to start Toaster
>=20
> @@ -20,8 +21,8 @@ Usage 2: source toaster manage [createsuperuser|lsupdat=
es|migrate|makemigrations
>  custom_extention()
>  {
>=20
> custom_extension=3D$BBBASEDIR/lib/toaster/orm/fixtures/custom_toaster_app=
end.sh
> -    if [ -f $custom_extension ] ; then
> -        $custom_extension $*
> +    if [ -f "$custom_extension" ] ; then
> +        $custom_extension "$*"
>      fi
>  }
>=20
> @@ -51,19 +52,19 @@ databaseCheck()
>  webserverKillAll()
>  {
>      local pidfile
> -    if [ -f ${BUILDDIR}/.toastermain.pid ] ; then
> +    if [ -f "${BUILDDIR}"/.toastermain.pid ] ; then

While it is technically correct, please put the quotes around the=20
entire string to make it more readable, i.e.:

    if [ -f "${BUILDDIR}/.toastermain.pid" ] ; then

This applies to the rest of the changes in this file.

>          custom_extention web_stop_postpend
>      else
>          custom_extention noweb_stop_postpend
>      fi
> -    for pidfile in ${BUILDDIR}/.toastermain.pid ${BUILDDIR}/.runbuilds.p=
id; do
> -        if [ -f ${pidfile} ]; then
> -            pid=3D`cat ${pidfile}`
> -            while kill -0 $pid 2>/dev/null; do
> -                kill -SIGTERM $pid 2>/dev/null
> +    for pidfile in "${BUILDDIR}"/.toastermain.pid "${BUILDDIR}"/.runbuil=
ds.pid; do
> +        if [ -f "${pidfile}" ]; then
> +            pid=3D`cat "${pidfile}"`
> +            while kill -0 "$pid" 2>/dev/null; do
> +                kill -SIGTERM "$pid" 2>/dev/null
>                  sleep 1
>              done
> -            rm  ${pidfile}
> +            rm  "${pidfile}"
>          fi
>      done
>  }
> @@ -84,8 +85,8 @@ webserverStartAll()
>      echo "Starting webserver..."
>=20
>      $MANAGE runserver --noreload "$ADDR_PORT" \
> -           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
> -           & echo $! >${BUILDDIR}/.toastermain.pid
> +           </dev/null >>"${BUILDDIR}"/toaster_web.log 2>&1 \
> +           & echo "$!" >"${BUILDDIR}"/.toastermain.pid
>=20
>      sleep 1
>=20
> @@ -95,7 +96,7 @@ webserverStartAll()
>      else
>          echo "Toaster development webserver started at http://$ADDR_PORT=
"
>          echo -e "\nYou can now run 'bitbake <target>' on the command lin=
e and monitor your build in Toaster.\nYou can also use a Toaster project to=
 configure and run a build.\n"
> -        custom_extention web_start_postpend $ADDR_PORT
> +        custom_extention web_start_postpend "$ADDR_PORT"
>      fi
>=20
>      return $retval
> @@ -131,8 +132,8 @@ verify_prereq() {
>      exp=3D$exp'vmax=3D["%02d" % int(n) for n in "\4".split(".")];'
>      exp=3D$exp'sys.exit(not (version \1 vmin and version \3 vmax))'
>      exp=3D$exp'/p'
> -    if ! sed -n "$exp" $reqfile | python3 - ; then
> -        req=3D`grep ^Django $reqfile`
> +    if ! sed -n "$exp" "$reqfile" | python3 - ; then
> +        req=3D`grep ^Django "$reqfile"`
>          echo "This program needs $req"
>          echo "Please install with pip3 install -r $reqfile"
>          return 2
> @@ -150,10 +151,10 @@ else
>      TOASTER=3D$0
>  fi
>=20
> -export BBBASEDIR=3D`dirname $TOASTER`/..
> +export BBBASEDIR=3D`dirname "$TOASTER"`/..
>  MANAGE=3D"python3 $BBBASEDIR/lib/toaster/manage.py"
>  if [ -z "$OE_ROOT" ]; then
> -    OE_ROOT=3D`dirname $TOASTER`/../..
> +    OE_ROOT=3D`dirname "$TOASTER"`/../..
>  fi
>=20
>  # this is the configuraton file we are using for toaster
> @@ -164,7 +165,7 @@ fi
>  # in the local layers that currently make using an arbitrary
>  # toasterconf.json difficult.
>=20
> -. $OE_ROOT/.templateconf
> +. "$OE_ROOT"/.templateconf
>  if [ -n "$TEMPLATECONF" ]; then
>      if [ ! -d "$TEMPLATECONF" ]; then
>          # Allow TEMPLATECONF=3Dmeta-xyz/conf as a shortcut
> @@ -199,10 +200,10 @@ for param in $*; do
>      webport=3D*)
>              ADDR_PORT=3D"${param#*=3D}"
>              # Split the addr:port string
> -            ADDR=3D`echo $ADDR_PORT | cut -f 1 -d ':'`
> -            PORT=3D`echo $ADDR_PORT | cut -f 2 -d ':'`
> +            ADDR=3D`echo "$ADDR_PORT" | cut -f 1 -d ':'`
> +            PORT=3D`echo "$ADDR_PORT" | cut -f 2 -d ':'`
>              # If only a port has been speified then set address to local=
host.
> -            if [ $ADDR =3D $PORT ] ; then
> +            if [ "$ADDR" =3D "$PORT" ] ; then
>                  ADDR_PORT=3D"localhost:$PORT"
>              fi
>      ;;
> @@ -229,7 +230,7 @@ for param in $*; do
>      esac
>  done
>=20
> -if [ `basename \"$0\"` =3D `basename \"${TOASTER}\"` ]; then
> +if [ `basename \""$0"\"` =3D `basename \""${TOASTER}"\"` ]; then

That is wrong (as the original code was wrong). Change it to:

if [ `basename "$0"` =3D `basename "${TOASTER}"` ]; then

>      echo "Error: This script needs to be sourced. Please run as . $TOAST=
ER"
>      return 1
>  fi
> @@ -265,7 +266,7 @@ fi
>  echo "The system will $CMD."
>=20
>  # Execute the commands
> -custom_extention toaster_prepend $CMD $ADDR_PORT
> +custom_extention toaster_prepend "$CMD" "$ADDR_PORT"
>=20
>  case $CMD in
>      start )
> @@ -279,7 +280,7 @@ case $CMD in
>          # Create configuration file
>          conf=3D${BUILDDIR}/conf/local.conf
>          line=3D'INHERIT+=3D"toaster buildhistory"'
> -        grep -q "$line" $conf || echo $line >> $conf
> +        grep -q "$line" "$conf" || echo "$line" >> "$conf"
>=20
>          if [ $WEBSERVER -eq 0 ] ; then
>              # Do not update the database for "noweb" unless
> @@ -290,17 +291,17 @@ case $CMD in
>                      return 4
>                  fi
>              fi
> -            custom_extention noweb_start_postpend $ADDR_PORT
> +            custom_extention noweb_start_postpend "$ADDR_PORT"
>          fi
> -        if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
> +        if [ "$WEBSERVER" -gt 0 ] && ! webserverStartAll; then
>              echo "Failed ${CMD}."
>              return 4
>          fi
>          export BITBAKE_UI=3D'toasterui'
>          if [ $TOASTER_BUILDSERVER -eq 1 ] ; then
>              $MANAGE runbuilds \
> -               </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
> -               & echo $! >${BUILDDIR}/.runbuilds.pid
> +               </dev/null >>"${BUILDDIR}"/toaster_runbuilds.log 2>&1 \
> +               & echo $! >"${BUILDDIR}"/.runbuilds.pid
>          else
>              echo "Toaster build server not started."
>          fi
> @@ -308,7 +309,7 @@ case $CMD in
>          # set fail safe stop system on terminal exit
>          trap stop_system SIGHUP
>          echo "Successful ${CMD}."
> -        custom_extention toaster_postpend $CMD $ADDR_PORT
> +        custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
>          return 0
>      ;;
>      stop )
> @@ -316,9 +317,9 @@ case $CMD in
>          echo "Successful ${CMD}."
>      ;;
>      manage )
> -        cd $BBBASEDIR/lib/toaster
> -        $MANAGE $manage_cmd
> +        cd "$BBBASEDIR"/lib/toaster
> +        "$MANAGE $manage_cmd"
>      ;;
>  esac
> -custom_extention toaster_postpend $CMD $ADDR_PORT
> +custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
>=20
> --
> 2.25.1

//Peter


