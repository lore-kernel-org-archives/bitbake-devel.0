Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id CE6C96FF72
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 17:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id C03491808E;
	Fri, 18 Dec 2015 18:11:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id fFxCNWWU4+Vi; Fri, 18 Dec 2015 18:11:46 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 665381808A;
	Fri, 18 Dec 2015 18:11:46 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 24CE011C4;
	Fri, 18 Dec 2015 18:11:46 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 1583311D;
	Fri, 18 Dec 2015 18:11:46 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id 105683E4CB;
	Fri, 18 Dec 2015 18:11:46 +0100 (CET)
Received: from xbox12.axis.com (10.0.5.26) by xmail3.se.axis.com (10.0.5.75)
	with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 18 Dec 2015 18:11:45
	+0100
Received: from XBOX02.axis.com (10.0.5.16) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1104.5;
	Fri, 18 Dec 2015 18:11:45 +0100
Received: from XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04]) by
	XBOX02.axis.com ([fe80::bcea:88d5:e1ff:8e04%12]) with mapi id
	15.00.1104.000; Fri, 18 Dec 2015 18:11:45 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Elliot Smith <elliot.smith@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 03/11] toaster: split long lines,
	add/remove whitespace
Thread-Index: AQHROOrqQIoOeFe6rUG34dBNbzXOmJ7Q+b9Q
Date: Fri, 18 Dec 2015 17:11:45 +0000
Message-ID: <a05ab7a891f1439e870ce2a9255a98f8@XBOX02.axis.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
	<a4863117888ede1cead1ddf43c7740226f61c5c2.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <a4863117888ede1cead1ddf43c7740226f61c5c2.1450370782.git.elliot.smith@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.55]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 03/11] toaster: split long lines, add/remove whitespace
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
X-List-Received-Date: Fri, 18 Dec 2015 17:11:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Elliot Smith
> Sent: den 17 december 2015 17:49
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 03/11] toaster: split long lines,
> add/remove whitespace
>=20
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>=20
> Made toaster script more readable by splitting long lines and
> removing and adding whitespace.
>=20
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bin/toaster | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/bin/toaster b/bin/toaster
> index f43bcb1..a849559 100755
> --- a/bin/toaster
> +++ b/bin/toaster
> @@ -37,7 +37,8 @@ webserverKillAll()
>              while kill -0 $pid 2>/dev/null; do
>                  kill -SIGTERM -$pid 2>/dev/null
>                  sleep 1
> -                # Kill processes if they are still running - may happen =
in interactive shells
> +                # Kill processes if they are still running - may happen
> +                # in interactive shells
>                  ps fux | grep "python.*manage.py runserver" | awk '{prin=
t $2}' | xargs kill
>              done
>              rm  ${pidfile}
> @@ -55,7 +56,7 @@ webserverStartAll()
>=20
>      retval=3D0
>      # you can always add a superuser later via
> -    # python bitbake/lib/toaster/manage.py python manage.py createsuperu=
ser --username=3D<ME>
> +    # ../bitbake/lib/toaster/manage.py createsuperuser --username=3D<ME>
>      python $BBBASEDIR/lib/toaster/manage.py migrate --noinput || retval=
=3D1
>=20
>      if [ $retval -eq 1 ]; then
> @@ -72,7 +73,9 @@ webserverStartAll()
>=20
>      echo "Starting webserver..."
>=20
> -    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT=
" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toa=
stermain.pid
> +    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT=
" \
> +           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
> +           & echo $! >${BUILDDIR}/.toastermain.pid

I would reformat that as:

    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" \
        </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 &
    echo $! >${BUILDDIR}/.toastermain.pid

>      sleep 1
>=20
> @@ -128,8 +131,10 @@ start_bitbake() {
>      fi
>      export BBSERVER=3D0.0.0.0:-1
>      export DATABASE_URL=3D`$BBBASEDIR/lib/toaster/manage.py get-dburl`
> -    if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only=
 if not inhibited
> -        bitbake --observe-only -u toasterui --remote-server=3D$BBSERVER =
-t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
> +    # we start the TOASTERUI only if not inhibited
> +    if [ $NOTOASTERUI -eq 0 ]; then
> +        bitbake --observe-only -u toasterui --remote-server=3D$BBSERVER =
-t xmlrpc \
> +            >>${BUILDDIR}/toaster_ui.log 2>&1 \
>              & echo $! >${BUILDDIR}/.toasterui.pid

Same here:

        bitbake --observe-only -u toasterui --remote-server=3D$BBSERVER -t =
xmlrpc \
            >>${BUILDDIR}/toaster_ui.log 2>&1 &
        echo $! >${BUILDDIR}/.toasterui.pid

>      fi
>      return 0
> @@ -146,7 +151,6 @@ check_pidbyfile() {
>      [ -e $1 ] && kill -0 `cat $1` 2>/dev/null
>  }
>=20
> -
>  notify_chldexit() {
>      if [ $NOTOASTERUI -eq 0 ]; then
>          check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
> @@ -154,7 +158,6 @@ notify_chldexit() {
>      fi
>  }
>=20
> -
>  verify_prereq() {
>      # Verify Django version
>      reqfile=3D$(python -c "import os; print os.path.realpath('$BBBASEDIR=
/toaster-requirements.txt')")
> @@ -171,7 +174,6 @@ verify_prereq() {
>      return 0
>  }
>=20
> -
>  # read command line parameters
>  if [ -n "$BASH_SOURCE" ] ; then
>      TOASTER=3D${BASH_SOURCE}
> @@ -207,7 +209,7 @@ if [ -n "$TEMPLATECONF" ]; then
>          fi
>          if [ ! -d "$TEMPLATECONF" ]; then
>              echo >&2 "Error: '$TEMPLATECONF' must be a directory contain=
ing toasterconf.json"
> -	    [ "$TOASTER_MANAGED" =3D '1' ] && exit 1 || return 1
> +            [ "$TOASTER_MANAGED" =3D '1' ] && exit 1 || return 1
>          fi
>      fi
>  fi
> @@ -216,10 +218,12 @@ if [ "$TOASTER_CONF" =3D "" ]; then
>      TOASTER_CONF=3D"$TEMPLATECONF/toasterconf.json"
>      export TOASTER_CONF=3D$(python -c "import os; print os.path.realpath=
('$TOASTER_CONF')")
>  fi
> +
>  if [ ! -f $TOASTER_CONF ]; then
>      echo "$TOASTER_CONF configuration file not found. Set TOASTER_CONF t=
o specify file or fix .templateconf"
>      [ "$TOASTER_MANAGED" =3D '1' ] && exit 1 || return 1
>  fi
> +
>  # this defines the dir toaster will use for
>  # 1) clones of layers (in _toaster_clones )
>  # 2) the build dir (in build)
> @@ -284,7 +288,8 @@ if [ "$TOASTER_CONF" =3D "" ]; then
>      export TOASTER_CONF=3D$(python -c "import os; print os.path.realpath=
('$TOASTER_CONF')")
>  fi
>  if [ ! -f $TOASTER_CONF ]; then
> -    echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF t=
o specify a path"
> +    echo "$TOASTER_CONF configuration file not found."
> +    echo " set TOASTER_CONF to specify a path"
>      return 1
>  fi
>  # this defines the dir toaster will use for
> @@ -293,7 +298,8 @@ fi
>  # 3) the sqlite db if that is being used.
>  # 4) pid's we need to clean up on exit/shutdown
>  # note: for future. in order to make this an arbitrary directory, we nee=
d to
> -# make sure that the toaster.sqlite file doesn't default to `pwd` like i=
t currently does.
> +# make sure that the toaster.sqlite file doesn't default to `pwd`
> +# like it currently does.
>  export TOASTER_DIR=3D`dirname $BUILDDIR`
>=20
>  # Determine the action. If specified by arguments, fine, if not, toggle =
it
> @@ -328,7 +334,8 @@ if [ ${CMD} =3D 'start' ] && [ $lock -eq 0 ]; then
>  fi
>=20
>  if [ ${CMD} =3D 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -=
0 `cat $BUILDDIR/.toastermain.pid`; then

You can break the above as:

if [ ${CMD} =3D 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] &&=20
   kill -0 `cat $BUILDDIR/.toastermain.pid`; then

> -    echo "Warning: bitbake appears to be dead, but the Toaster web serve=
r is running. Something fishy is going on." 1>&2
> +    echo "Warning: bitbake appears to be dead, but the Toaster web serve=
r is running." 1>&2
> +    echo " Something fishy is going on." 1>&2
>      echo "Cleaning up the web server to start from a clean slate."
>      webserverKillAll
>  fi
> --
> 1.9.3

//Peter


