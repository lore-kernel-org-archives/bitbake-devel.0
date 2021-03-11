Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.3295.1615500889735930325
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 14:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=UZiOQeJ7;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1615500890;
  x=1647036890;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=Hfzr+gD3ow4of7BY3t2BeO504ZTnVUjbfr2/Ij3woGk=;
  b=UZiOQeJ7VEp48OTbmjewneTXAZcfqMZubJp+tbr7XpDYy6/z31ECbL46
   sIJJQpIO342mocLQL4Oyek1X/cdSr0ZqcvMoSrzjBQyto8JcBemM5Kure
   wDoVq5vDMw7YFWZQr+C7EIFI+0i6/8lW83sSfQze30RkaYbEwfatXDJds
   GzrLx4b4KHj3607qbnjbEuOdcid1Et5J+i9CvNeN41X8Hx/2ZdZEAtBef
   QQUenPzywo5f0uy2k3Q9Wx6xh017I4o28wdrvoOlBdL3KmevYYRGKzJvK
   rkYPromftiLwcEO3Aqp0W4pLzPvsG5JULQqoRq151OwsQNx5rft5neaHj
   Q==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] event: Fix multiconfig event handler change performance regressions
Thread-Topic: [bitbake-devel] [PATCH] event: Fix multiconfig event handler
 change performance regressions
Thread-Index: AQHXFnzk55L6+7WgvUS8g8a2FurUnKp/P5Zw
Date: Thu, 11 Mar 2021 22:14:47 +0000
Message-ID: <ea3cf67c8b174f3eab75d68d14e72440@XBOX03.axis.com>
References: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-Groupsio-MsgNum: 12090
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_003_ea3cf67c8b174f3eab75d68d14e72440XBOX03axiscom_"

--_003_ea3cf67c8b174f3eab75d68d14e72440XBOX03axiscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 11 mars 2021 14:46
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] event: Fix multiconfig event handler
> change performance regressions
>=20
> There were two issues in this code, firstly the code could stack
> duplicates
> in the variable, secondly, calling "if data" caused the datastore to
> compute
> len(data) which is comparitively expensive. Checking "if data is not None=
"
> is much much faster/cheaper.
>=20
> The issue was clear from "bitbake -p -P" output where the time in
> register()
> showed large amounts of time in the __len__ function of the datastore.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/event.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 3e5718395b..22171a9ca5 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -118,7 +118,7 @@ def fire_class_handlers(event, d):
>              if _eventfilter:
>                  if not _eventfilter(name, handler, event, d):
>                      continue
> -            if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
> +            if d and not name in (d.getVar("__BBHANDLERS_MC") or set()):
>                  continue
>              execute_handler(name, handler, event, d)
>=20
> @@ -232,15 +232,15 @@ noop =3D lambda _: None
>  def register(name, handler, mask=3DNone, filename=3DNone, lineno=3DNone,
> data=3DNone):
>      """Register an Event handler"""
>=20
> -    if data and data.getVar("BB_CURRENT_MC"):
> +    if data is not None and data.getVar("BB_CURRENT_MC"):
>          mc =3D data.getVar("BB_CURRENT_MC")
>          name =3D '%s%s' % (mc.replace('-', '_'), name)
>=20
>      # already registered
>      if name in _handlers:
> -        if data:
> -            bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or [])
> -            bbhands_mc.append(name)
> +        if data is not None:
> +            bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or set())
> +            bbhands_mc.add(name)
>              data.setVar("__BBHANDLERS_MC", bbhands_mc)
>          return AlreadyRegistered
>=20
> @@ -278,16 +278,16 @@ def register(name, handler, mask=3DNone,
> filename=3DNone, lineno=3DNone, data=3DNone):
>                      _event_handler_map[m] =3D {}
>                  _event_handler_map[m][name] =3D True
>=20
> -        if data:
> -            bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or [])
> -            bbhands_mc.append(name)
> +        if data is not None:
> +            bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or set())
> +            bbhands_mc.add(name)
>              data.setVar("__BBHANDLERS_MC", bbhands_mc)
>=20
>          return Registered
>=20
>  def remove(name, handler, data=3DNone):
>      """Remove an Event handler"""
> -    if data:
> +    if data is not None:
>          if data.getVar("BB_CURRENT_MC"):
>              mc =3D data.getVar("BB_CURRENT_MC")
>              name =3D '%s%s' % (mc.replace('-', '_'), name)
> @@ -299,8 +299,8 @@ def remove(name, handler, data=3DNone):
>          if name in _event_handler_map[event]:
>              _event_handler_map[event].pop(name)
>=20
> -    if data:
> -        bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or [])
> +    if data is not None:
> +        bbhands_mc =3D (data.getVar("__BBHANDLERS_MC") or set())
>          if name in bbhands_mc:
>              bbhands_mc.remove(name)
>              data.setVar("__BBHANDLERS_MC", bbhands_mc)
> --
> 2.27.0

While this greatly improves the situation, it is still not good. Here are s=
ome=20
numbers for me when parsing poky + openembedded + our layers:

poky + openembedded + axis dunfell
Parsing recipes: 100% |###############################| Time: 0:00:39
Parsing of 3935 .bb files complete (0 cached, 3935 parsed).=20
5767 targets, 711 skipped, 0 masked, 0 errors.

poky + openembedded + axis gatesgarth
Parsing recipes: 100% |###############################| Time: 0:00:39
Parsing of 4051 .bb files complete (0 cached, 4051 parsed).=20
5490 targets, 726 skipped, 0 masked, 0 errors.

poky + openembedded + axis master
Parsing recipes: 100% |###############################| Time: 0:01:07
Parsing of 4111 .bb files complete (0 cached, 4111 parsed).=20
5607 targets, 732 skipped, 12 masked, 0 errors.

And here are similar measurements with only the poky and openembedded layer=
s=20
(meta, meta-poky, meta-gplv2, meta-oe, meta-filesystems, meta-networking,=20
meta-python and meta-webserver):

poky + openembedded gatesgarth
Parsing recipes: 100% |###############################| Time: 0:00:17
Parsing of 2289 .bb files complete (0 cached, 2289 parsed).=20
3537 targets, 91 skipped, 0 masked, 0 errors.

poky + openembedded master
Parsing recipes: 100% |###############################| Time: 0:00:27
Parsing of 2354 .bb files complete (0 cached, 2354 parsed).=20
3659 targets, 64 skipped, 0 masked, 0 errors.

I have attached profiling logs (first 40 lines) for a gatesgarth run and a=
=20
master run. If I read the data correctly, it seems that during the master=20
parsing, there are a lot of calls to fnmatch.translate, posix.read and=20
_posixsubprocess.fork_exec that are not there during the gatesgarth parsing=
.

//Peter


--_003_ea3cf67c8b174f3eab75d68d14e72440XBOX03axiscom_
Content-Type: text/plain; name="profile-gatesgarth.txt"
Content-Description: profile-gatesgarth.txt
Content-Disposition: attachment; filename="profile-gatesgarth.txt"; size=3433;
	creation-date="Thu, 11 Mar 2021 22:03:12 GMT";
	modification-date="Thu, 11 Mar 2021 22:02:37 GMT"
Content-Transfer-Encoding: base64

ICAgICAgICAgMTEyMjM0NzY5NyBmdW5jdGlvbiBjYWxscyAoMTA5NTQ5MzI4NiBwcmltaXRpdmUg
Y2FsbHMpIGluIDgxNS4xNjYgc2Vjb25kcw0KDQogICBPcmRlcmVkIGJ5OiBpbnRlcm5hbCB0aW1l
DQoNCiAgIG5jYWxscyAgdG90dGltZSAgcGVyY2FsbCAgY3VtdGltZSAgcGVyY2FsbCBmaWxlbmFt
ZTpsaW5lbm8oZnVuY3Rpb24pDQoyMzAxNzk2Ni8xMzA0MDQ5OCAgIDU3LjkzMSAgICAwLjAwMCAg
MzM5LjAzNiAgICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9kYXRhX3NtYXJ0LnB5OjY4OShnZXRWYXJG
bGFnKQ0KMjA0NDk0MDI5ICAgNTIuNDU2ICAgIDAuMDAwICAgNTIuNDU2ICAgIDAuMDAwIHttZXRo
b2QgJ21hdGNoJyBvZiAncmUuUGF0dGVybicgb2JqZWN0c30NCiAgMTMxMjU5MyAgIDM4Ljk0MCAg
ICAwLjAwMCAgIDM4Ljk0MCAgICAwLjAwMCB7YnVpbHQtaW4gbWV0aG9kIGJ1aWx0aW5zLmNvbXBp
bGV9DQogNDgzMTUyNjEgICAzMS4xMjggICAgMC4wMDAgICA2MS4zODMgICAgMC4wMDAgYml0YmFr
ZS9saWIvYmIvZGF0YV9zbWFydC5weTo5MzgoX19pdGVyX18pDQogMjE4ODY0NTkgICAyOS4wODQg
ICAgMC4wMDAgICAzMi43NjAgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weTo0
NTkoX2ZpbmRWYXIpDQogMTI5ODIxNTMgICAyNy41MDMgICAgMC4wMDAgICAyNy41MDQgICAgMC4w
MDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weTo4MyhfX2luaXRfXykNCiAgMzM0NjkyOCAg
IDI1LjQ4MCAgICAwLjAwMCAgMjMzLjE0OSAgICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9kYXRhLnB5
OjI3NShidWlsZF9kZXBlbmRlbmNpZXMpDQogIDE4ODUwNzMgICAyNS4xOTUgICAgMC4wMDAgICAz
OC42NTIgICAgMC4wMDAgL3Vzci9saWI2NC9weXRob24zLjcvbG9nZ2luZy9fX2luaXRfXy5weTox
MzA0KF9jbGVhcl9jYWNoZSkNCiAgNjQ2Mzc1MSAgIDI0Ljk5NyAgICAwLjAwMCAgIDM3LjMzNSAg
ICAwLjAwMCAvdXNyL2xpYjY0L3B5dGhvbjMuNy9wb3NpeHBhdGgucHk6MzM4KG5vcm1wYXRoKQ0K
Njc5MjYvMTE0OTggICAyMy43ODMgICAgMC4wMDAgICAyNy40NTkgICAgMC4wMDIgYml0YmFrZS9s
aWIvYmIvZGF0YV9zbWFydC5weTo5NDEoa2V5bGlzdCkNCjEyOTgyMTUzLzgwNjE2MDkgICAyMS44
MDcgICAgMC4wMDAgIDMwOS4xOTkgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5w
eTozOTEoZXhwYW5kV2l0aFJlZnMpDQogICAgIDQ3ODcgICAyMS4wNDEgICAgMC4wMDQgICAzMC4z
NjIgICAgMC4wMDYgYml0YmFrZS9saWIvYmIvZGF0YS5weTo0MDAoZ2VuZXJhdGVfZGVwZW5kZW5j
eV9oYXNoKQ0KMTQxOTg1MTkvOTgwMTc5NiAgIDIwLjIxNSAgICAwLjAwMCAgMjc5LjE0OCAgICAw
LjAwMCB7bWV0aG9kICdzdWInIG9mICdyZS5QYXR0ZXJuJyBvYmplY3RzfQ0KICAxNDMwMTA4ICAg
MTkuNjg4ICAgIDAuMDAwICAgNjcuNTI5ICAgIDAuMDAwIC91c3IvbGliNjQvcHl0aG9uMy43L2Zu
bWF0Y2gucHk6NDgoZmlsdGVyKQ0KMTI4MTQyOC83NDczNjUgICAxNS40MDIgICAgMC4wMDAgIDIy
My44NjIgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weToxMDQocHl0aG9uX3N1
YikNCjExNTk5NDMyMCAgIDE1LjM0MCAgICAwLjAwMCAgIDE1LjM1MSAgICAwLjAwMCB7YnVpbHQt
aW4gbWV0aG9kIGJ1aWx0aW5zLmlzaW5zdGFuY2V9DQogICAgIDQ3ODcgICAxNC42MjMgICAgMC4w
MDMgIDI4Ni4zNTkgICAgMC4wNjAgYml0YmFrZS9saWIvYmIvZGF0YS5weTozNzQoZ2VuZXJhdGVf
ZGVwZW5kZW5jaWVzKQ0KICAyMDEzMjMwICAgMTEuOTQ1ICAgIDAuMDAwICAgMTEuOTQ1ICAgIDAu
MDAwIHtidWlsdC1pbiBtZXRob2QgX2hhc2hsaWIub3BlbnNzbF9zaGEyNTZ9DQogIDE1MTg5MDYg
ICAxMC41MTkgICAgMC4wMDAgICAxMy42MTMgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9z
bWFydC5weTo1NjcoX3NldHZhcl91cGRhdGVfb3ZlcnJpZGVzKQ0KNjMwMDI2MC8zNjkwNzUwICAg
MTAuMzk2ICAgIDAuMDAwICAxOTIuODc1ICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2RhdGFfc21h
cnQucHk6OTIodmFyX3N1YikNCiAgMTU4NjYxMyAgIDEwLjI5NCAgICAwLjAwMCAgIDMwLjU2OSAg
ICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9kYXRhX3NtYXJ0LnB5OjQ4MihzZXRWYXIpDQogNTc0MjEx
MzQgICAgOS42MTMgICAgMC4wMDAgICAgOS42MTMgICAgMC4wMDAge21ldGhvZCAnc3RhcnRzd2l0
aCcgb2YgJ3N0cicgb2JqZWN0c30NCiAyNTIzOTQ1NCAgICA5LjI1NiAgICAwLjAwMCAgICA5LjI1
NiAgICAwLjAwMCB7bWV0aG9kICdzcGxpdCcgb2YgJ3N0cicgb2JqZWN0c30NCiAgMzM5MjQ5NiAg
ICA4LjU5MCAgICAwLjAwMCAgIDI3LjY5NCAgICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9kYXRhX3Nt
YXJ0LnB5Ojg2MShnZXRWYXJGbGFncykNCiAxMDcyNjgwNyAgICA3Ljg1NSAgICAwLjAwMCAgIDE2
Ljg2NiAgICAwLjAwMCAvdXNyL2xpYjY0L3B5dGhvbjMuNy9jb3B5LnB5OjY2KGNvcHkpDQogIDE3
ODcyMjYgICAgNy44MjEgICAgMC4wMDAgICAxOC4yNzggICAgMC4wMDAgYml0YmFrZS9saWIvYmIv
Y29kZXBhcnNlci5weToyODQocGFyc2VfcHl0aG9uKQ0KICAxNzg3MjI2ICAgIDcuNjE5ICAgIDAu
MDAwICAgNjIuMjYzICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2NvZGVwYXJzZXIucHk6MjczKF9f
aW5pdF9fKQ0KICAyNTk5OTk1ICAgIDcuNDczICAgIDAuMDAwICAgIDcuNDczICAgIDAuMDAwIHti
dWlsdC1pbiBtZXRob2QgcG9zaXgubHN0YXR9DQogNDU3OTkzOTkgICAgNy4wODIgICAgMC4wMDAg
ICAgNy4wODIgICAgMC4wMDAge21ldGhvZCAnZ2V0JyBvZiAnZGljdCcgb2JqZWN0c30NCiAgODQ1
NTkyOCAgICA2LjcxMiAgICAwLjAwMCAgICA2LjcxMiAgICAwLjAwMCB7bWV0aG9kICdjb3B5JyBv
ZiAnZGljdCcgb2JqZWN0c30NCiAxMjI3MTc3NSAgICA2LjIwMCAgICAwLjAwMCAgICA5LjQ0NCAg
ICAwLjAwMCAvdXNyL2xpYjY0L3B5dGhvbjMuNy9yZS5weToyNzEoX2NvbXBpbGUpDQogIDM0NzAy
NzcgICAgNi4wODAgICAgMC4wMDAgICAgOS4zOTUgICAgMC4wMDAgL3Vzci9saWI2NC9weXRob24z
LjcvcG9zaXhwYXRoLnB5Ojc1KGpvaW4pDQogMjAwMTM1NDkgICAgNS43ODYgICAgMC4wMDAgICAz
NC4zMTAgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YS5weTozNzYoPGdlbmV4cHI+KQ0KICAg
IDMzNjIxICAgIDUuNDQyICAgIDAuMDAwICAgMjguNzMxICAgIDAuMDAxIG1ldGEvbGliL29lL2xp
Y2Vuc2UucHk6MTAobGljZW5zZV9vaykNCiAgMTA5MDcyOSAgICA1LjQwOSAgICAwLjAwMCAgICA1
LjQwOSAgICAwLjAwMCB7YnVpbHQtaW4gbWV0aG9kIHBvc2l4LnN0YXR9DQogNjY4MTQ2NDIgICAg
NS4zNzYgICAgMC4wMDAgICAgNS4zNzYgICAgMC4wMDAge21ldGhvZCAnYXBwZW5kJyBvZiAnbGlz
dCcgb2JqZWN0c30NCg==

--_003_ea3cf67c8b174f3eab75d68d14e72440XBOX03axiscom_
Content-Type: text/plain; name="profile-master.txt"
Content-Description: profile-master.txt
Content-Disposition: attachment; filename="profile-master.txt"; size=3480;
	creation-date="Thu, 11 Mar 2021 22:03:14 GMT";
	modification-date="Thu, 11 Mar 2021 22:02:57 GMT"
Content-Transfer-Encoding: base64

ICAgICAgICAgMTkxODE3ODMzOCBmdW5jdGlvbiBjYWxscyAoMTg5MDgyNTYyMSBwcmltaXRpdmUg
Y2FsbHMpIGluIDEyNjQuNDE2IHNlY29uZHMNCg0KICAgT3JkZXJlZCBieTogaW50ZXJuYWwgdGlt
ZQ0KDQogICBuY2FsbHMgIHRvdHRpbWUgIHBlcmNhbGwgIGN1bXRpbWUgIHBlcmNhbGwgZmlsZW5h
bWU6bGluZW5vKGZ1bmN0aW9uKQ0KNDczMTE2OTU5ICAxMDguMTc5ICAgIDAuMDAwICAxMDguMTc5
ICAgIDAuMDAwIHttZXRob2QgJ21hdGNoJyBvZiAncmUuUGF0dGVybicgb2JqZWN0c30NCiAgICAg
OTQ4MyAgIDgwLjMyNiAgICAwLjAwOCAgIDgwLjMyNiAgICAwLjAwOCB7YnVpbHQtaW4gbWV0aG9k
IHBvc2l4LnJlYWR9DQogMTQxMzY5NTcgICA3OS4wMTggICAgMC4wMDAgIDE3NS4xOTIgICAgMC4w
MDAgL3Vzci9saWI2NC9weXRob24zLjcvZm5tYXRjaC5weTo3NCh0cmFuc2xhdGUpDQoyNTU0NTIw
Ni8xNTM0NTgzMCAgIDYzLjk4MSAgICAwLjAwMCAgNDkwLjc3MyAgICAwLjAwMCBiaXRiYWtlL2xp
Yi9iYi9kYXRhX3NtYXJ0LnB5OjY4OShnZXRWYXJGbGFnKQ0KMTM5NTA2MzkyICAgNDcuNTkwICAg
IDAuMDAwICAgOTQuNTY4ICAgIDAuMDAwIC91c3IvbGliNjQvcHl0aG9uMy43L3JlLnB5OjI1Mihl
c2NhcGUpDQogIDI5Mjg1NDAgICA0NS45MDIgICAgMC4wMDAgIDE4OS4xMDYgICAgMC4wMDAgL3Vz
ci9saWI2NC9weXRob24zLjcvZm5tYXRjaC5weTo0OChmaWx0ZXIpDQogICAgIDMxNjEgICA0Mi45
MDcgICAgMC4wMTQgICA0Mi45NTcgICAgMC4wMTQge2J1aWx0LWluIG1ldGhvZCBfcG9zaXhzdWJw
cm9jZXNzLmZvcmtfZXhlY30NCiAgMTM1MDczMSAgIDQwLjI0NyAgICAwLjAwMCAgIDQwLjI0NyAg
ICAwLjAwMCB7YnVpbHQtaW4gbWV0aG9kIGJ1aWx0aW5zLmNvbXBpbGV9DQoxMzk1MTM2OTkgICAz
Ni40MDkgICAgMC4wMDAgICAzNi40MDkgICAgMC4wMDAge21ldGhvZCAndHJhbnNsYXRlJyBvZiAn
c3RyJyBvYmplY3RzfQ0KIDUwNjg2Nzg1ICAgMzUuMTE5ICAgIDAuMDAwICAgNjYuMTc1ICAgIDAu
MDAwIGJpdGJha2UvbGliL2JiL2RhdGFfc21hcnQucHk6OTM4KF9faXRlcl9fKQ0KIDE1MDM5MzY3
ICAgMzUuMDk1ICAgIDAuMDAwICAgMzUuMDk1ICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2RhdGFf
c21hcnQucHk6ODMoX19pbml0X18pDQogMjQyOTMwMDcgICAzMi43NDcgICAgMC4wMDAgICAzNi41
NDkgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weTo0NTkoX2ZpbmRWYXIpDQoy
Nzc2Nzk0OTUgICAyOS44NDkgICAgMC4wMDAgICAyOS44NDkgICAgMC4wMDAge2J1aWx0LWluIG1l
dGhvZCBidWlsdGlucy5pc2luc3RhbmNlfQ0KICA3MDcwODg2ICAgMjYuNTI2ICAgIDAuMDAwICAg
MzkuNTkyICAgIDAuMDAwIC91c3IvbGliNjQvcHl0aG9uMy43L3Bvc2l4cGF0aC5weTozMzgobm9y
bXBhdGgpDQogIDMzOTcyMTIgICAyNS41NDkgICAgMC4wMDAgIDMzNS43MDUgICAgMC4wMDAgYml0
YmFrZS9saWIvYmIvZGF0YS5weToyNzUoYnVpbGRfZGVwZW5kZW5jaWVzKQ0KICAxOTM1MDE5ICAg
MjUuMDE3ICAgIDAuMDAwICAgMzguMTgwICAgIDAuMDAwIC91c3IvbGliNjQvcHl0aG9uMy43L2xv
Z2dpbmcvX19pbml0X18ucHk6MTMwNChfY2xlYXJfY2FjaGUpDQo2OTI4OC8xMTcyNSAgIDI0LjQ4
MiAgICAwLjAwMCAgIDI4LjI0MyAgICAwLjAwMiBiaXRiYWtlL2xpYi9iYi9kYXRhX3NtYXJ0LnB5
Ojk0MShrZXlsaXN0KQ0KMTUwMzkzNjcvOTk4MDQxNSAgIDIzLjM3NiAgICAwLjAwMCAgNDUzLjEw
MyAgICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9kYXRhX3NtYXJ0LnB5OjM5MShleHBhbmRXaXRoUmVm
cykNCiAgICAgNDg5NiAgIDIxLjM1NiAgICAwLjAwNCAgIDMwLjY5NSAgICAwLjAwNiBiaXRiYWtl
L2xpYi9iYi9kYXRhLnB5OjQwMChnZW5lcmF0ZV9kZXBlbmRlbmN5X2hhc2gpDQo4MzEyMzg0LzM4
MjUyNjEgICAxOC4xMTUgICAgMC4wMDAgIDQxMi44NDMgICAgMC4wMDAge21ldGhvZCAnc3ViJyBv
ZiAncmUuUGF0dGVybicgb2JqZWN0c30NCjEzMTkxMDYvNzczODIwICAgMTYuMjY2ICAgIDAuMDAw
ICAzNTguNDc1ICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2RhdGFfc21hcnQucHk6MTA0KHB5dGhv
bl9zdWIpDQogICAgIDQ4OTYgICAxNC45MTcgICAgMC4wMDMgIDM5MS41MDAgICAgMC4wODAgYml0
YmFrZS9saWIvYmIvZGF0YS5weTozNzQoZ2VuZXJhdGVfZGVwZW5kZW5jaWVzKQ0KIDE0MjM5MjY3
ICAgMTMuMDg0ICAgIDAuMDAwICAgMTguMzc5ICAgIDAuMDAwIC91c3IvbGliNjQvcHl0aG9uMy43
L3JlLnB5OjI3MShfY29tcGlsZSkNCiAxNDEzNjk1NyAgIDEyLjcxNCAgICAwLjAwMCAgMjEyLjE5
MyAgICAwLjAwMCAvdXNyL2xpYjY0L3B5dGhvbjMuNy9mbm1hdGNoLnB5OjM4KF9jb21waWxlX3Bh
dHRlcm4pDQogMTIxOTUyNzggICAxMS45MzYgICAgMC4wMDAgIDE4Ny44MjAgICAgMC4wMDAgL3Vz
ci9saWI2NC9weXRob24zLjcvZm5tYXRjaC5weTo2NChmbm1hdGNoY2FzZSkNCiAgMjA2NTc0OCAg
IDExLjg3NiAgICAwLjAwMCAgIDExLjg3NiAgICAwLjAwMCB7YnVpbHQtaW4gbWV0aG9kIF9oYXNo
bGliLm9wZW5zc2xfc2hhMjU2fQ0KICAxNzc0ODk1ICAgMTEuMzk4ICAgIDAuMDAwICAgMzIuMzQ3
ICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2RhdGFfc21hcnQucHk6NDgyKHNldFZhcikNCiAgMTcx
MTQ0MCAgIDEwLjkzOCAgICAwLjAwMCAgIDE0LjE2MCAgICAwLjAwMCBiaXRiYWtlL2xpYi9iYi9k
YXRhX3NtYXJ0LnB5OjU2Nyhfc2V0dmFyX3VwZGF0ZV9vdmVycmlkZXMpDQo2NDE0Mzk4LzM3Nzcy
NzcgICAxMC40MzUgICAgMC4wMDAgIDMyOC45MzIgICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0
YV9zbWFydC5weTo5Mih2YXJfc3ViKQ0KIDYwNzE5Nzk4ICAgMTAuMTAxICAgIDAuMDAwICAgMTAu
MTAxICAgIDAuMDAwIHttZXRob2QgJ3N0YXJ0c3dpdGgnIG9mICdzdHInIG9iamVjdHN9DQogMjcw
OTc1NjYgICAgOS43MTAgICAgMC4wMDAgICAgOS43MTAgICAgMC4wMDAge21ldGhvZCAnc3BsaXQn
IG9mICdzdHInIG9iamVjdHN9DQogIDM0NzY4MjIgICAgOC44OTMgICAgMC4wMDAgICAyOC41MzAg
ICAgMC4wMDAgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weTo4NjEoZ2V0VmFyRmxhZ3MpDQog
IDE4MzYzMzkgICAgOC4yODkgICAgMC4wMDAgICAxOC42NDMgICAgMC4wMDAgYml0YmFrZS9saWIv
YmIvY29kZXBhcnNlci5weToyODQocGFyc2VfcHl0aG9uKQ0KICAxODM2MzM5ICAgIDcuOTgxICAg
IDAuMDAwICAgNjIuMjgzICAgIDAuMDAwIGJpdGJha2UvbGliL2JiL2NvZGVwYXJzZXIucHk6Mjcz
KF9faW5pdF9fKQ0KIDExMjY1NjA4ICAgIDcuOTMyICAgIDAuMDAwICAgMTcuMzE2ICAgIDAuMDAw
IC91c3IvbGliNjQvcHl0aG9uMy43L2NvcHkucHk6NjYoY29weSkNCiAgMjU0MDI2NyAgICA3LjI1
OCAgICAwLjAwMCAgICA3LjI1OCAgICAwLjAwMCB7YnVpbHQtaW4gbWV0aG9kIHBvc2l4LmxzdGF0
fQ0K

--_003_ea3cf67c8b174f3eab75d68d14e72440XBOX03axiscom_--
