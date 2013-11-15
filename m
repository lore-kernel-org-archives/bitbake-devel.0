Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f47.google.com (mail-oa0-f47.google.com
	[209.85.219.47])
	by mail.openembedded.org (Postfix) with ESMTP id 0E86D6D7C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:36:02 +0000 (UTC)
Received: by mail-oa0-f47.google.com with SMTP id i7so3751596oag.20
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 03:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=NhyluImHT9VyH7sFaZUQLoNoyi2Tn4p7yU3U9MmB+VI=;
	b=N7OK/T2BMOlBwml0n3KK0XJ2dtf/321ZaFAx0YgvoZtO1ehxTECOeIaZfrTfr7I+/1
	L2dl0KuwwqcHjU6o/oJhPoR2snu/yxb90w5VG7LR3OMr0WvIGyBIr+uqdY4OTYxE9U/w
	uzCCnKXpM66YWFioRWGuZ2eIBGQrsZlEvAoGJGpv+5YH5ztqrpIURfGdTsVv23GzHHwC
	GJU2/+gT4hegms5casar5WOA86sfUsJtsH848a8apbngpShQI91ZY+ruWJiB+9lZC7y2
	gSnU0hJwJamljVUbKkZImGxg+l7ttOLi3uV9UP9IJUpvpdP3VXrm2ouQUonuqikT5fuR
	yJkQ==
X-Gm-Message-State: ALoCoQlSBIhCqykp2xVOXMCwaMGJ+8AopV4PsFfrPyVdmnzdXHN3sW1tbxhqUHQ+E9aKbx0AY8WR
X-Received: by 10.182.117.195 with SMTP id kg3mr6386821obb.17.1384515364535;
	Fri, 15 Nov 2013 03:36:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.86.193 with HTTP; Fri, 15 Nov 2013 03:35:44 -0800 (PST)
In-Reply-To: <1384514900.6460.146.camel@ted>
References: <1384426381-7869-2-git-send-email-alexandru.damian@intel.com>
	<1384437390-10392-1-git-send-email-alexandru.damian@intel.com>
	<1384514900.6460.146.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 15 Nov 2013 11:35:44 +0000
Message-ID: <CAJ2CSBtws+OFMYHWGXcMoUfpsJNw1arqr_SLEUcFW_9wArgKEw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] cooker, toaster: variable definition tracking
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
X-List-Received-Date: Fri, 15 Nov 2013 11:36:03 -0000
Content-Type: multipart/alternative; boundary=089e0149c5067d59b604eb359ac0

--089e0149c5067d59b604eb359ac0
Content-Type: text/plain; charset=UTF-8

Not sure about what leftover you're referring to... the commit message is
not right ?


Alex


On Fri, Nov 15, 2013 at 11:28 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2013-11-14 at 13:56 +0000, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > In order to track the file where a configuration
> > variable was defined, this patch bring these changes:
> >
> > * a new feature is defined in CookerFeatures, named
> > BASEDATASTORE_TRACKING. When a UI requests BASEDATASTORE_TRACKING,
> > the base variable definition are tracked when configuration
> > is parsed.
> >
> > * getAllKeysWithFlags now includes variable history in the
> > data dump
> >
> > * toaster_ui.py will record the operation, file path
> > and line number where the variable was changes
> >
> > * toaster Simple UI will display the file path
> > and line number for Configuration page
> >
> > There is a change in the models to accomodate the recording
> > of variable change history.
> >
> > [YOCTO #5227]
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  lib/bb/cooker.py                                   | 15 ++++++++++++---
> >  lib/bb/cookerdata.py                               |  1 +
> >  lib/bb/ui/buildinfohelper.py                       | 14 ++++++++++----
> >  lib/bb/ui/toasterui.py                             |  2 +-
> >  lib/toaster/bldviewer/templates/configuration.html |  6 ++++--
> >  lib/toaster/orm/models.py                          |  6 +++++-
> >  6 files changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index 0580cd5..4c9067b 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -81,7 +81,7 @@ class SkippedPackage:
> >
> >
> >  class CookerFeatures(object):
> > -    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE] = range(2)
> > +    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE,
> BASEDATASTORE_TRACKING] = range(3)
> >
> >      def __init__(self):
> >          self._features=set()
> > @@ -177,6 +177,9 @@ class BBCooker:
> >          self.data.disableTracking()
> >
> >      def loadConfigurationData(self):
> > +        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
> > +            self.enableDataTracking()
> > +
> >          self.initConfigurationData()
> >          self.databuilder.parseBaseConfiguration()
> >          self.data = self.databuilder.data
> > @@ -189,6 +192,10 @@ class BBCooker:
> >          bb.data.update_data(self.event_data)
> >          bb.parse.init_parser(self.event_data)
> >
> > +        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
> > +            self.disableDataTracking()
> > +
> > +
> >      def modifyConfigurationVar(self, var, val, default_file, op):
> >          if op == "append":
> >              self.appendConfigurationVar(var, val, default_file)
> > @@ -320,7 +327,6 @@ class BBCooker:
> >          open(confpath, 'w').close()
> >
> >      def parseConfiguration(self):
> > -
> >          # Set log file verbosity
> >          verboselogs =
> bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", "0"))
> >          if verboselogs:
> > @@ -1175,7 +1181,10 @@ class BBCooker:
> >              try:
> >                  v = self.data.getVar(k, True)
> >                  if not k.startswith("__") and not isinstance(v,
> bb.data_smart.DataSmart):
> > -                    dump[k] = { 'v' : v }
> > +                    dump[k] = {
> > +    'v' : v ,
> > +    'history' : self.data.varhistory.variable(k),
> > +                    }
> >                      for d in flaglist:
> >                          dump[k][d] = self.data.getVarFlag(k, d)
> >              except Exception as e:
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index e640ed0..1cc7bc2 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -127,6 +127,7 @@ class CookerConfiguration(object):
> >          self.dump_signatures = False
> >          self.dry_run = False
> >          self.tracking = False
> > +        self.server_only = False
> >
> >          self.env = {}
> >
>
> Patch looks ok in general but I think the above is leftover and
> unneeded?
>
> Cheers,
>
> Richard
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--089e0149c5067d59b604eb359ac0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Not sure about what leftover you&#39;re referring to.=
.. the commit message is not right ?<br><br><br></div>Alex<br></div><div cl=
ass=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Nov 15, 2013=
 at 11:28 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richar=
d.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundat=
ion.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2013-11-14 at 13:56 +0000, Alex DAMIAN wrote:<br>
&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; In order to track the file where a configuration<br>
&gt; variable was defined, this patch bring these changes:<br>
&gt;<br>
&gt; * a new feature is defined in CookerFeatures, named<br>
&gt; BASEDATASTORE_TRACKING. When a UI requests BASEDATASTORE_TRACKING,<br>
&gt; the base variable definition are tracked when configuration<br>
&gt; is parsed.<br>
&gt;<br>
&gt; * getAllKeysWithFlags now includes variable history in the<br>
&gt; data dump<br>
&gt;<br>
&gt; * toaster_ui.py will record the operation, file path<br>
&gt; and line number where the variable was changes<br>
&gt;<br>
&gt; * toaster Simple UI will display the file path<br>
&gt; and line number for Configuration page<br>
&gt;<br>
&gt; There is a change in the models to accomodate the recording<br>
&gt; of variable change history.<br>
&gt;<br>
&gt; [YOCTO #5227]<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/cooker.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 15 ++++++++++++---<br>
&gt; =C2=A0lib/bb/cookerdata.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 +<=
br>
&gt; =C2=A0lib/bb/ui/buildinfohelper.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++++++++++----<br>
&gt; =C2=A0lib/bb/ui/toasterui.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>
&gt; =C2=A0lib/toaster/bldviewer/templates/configuration.html | =C2=A06 +++=
+--<br>
&gt; =C2=A0lib/toaster/orm/models.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A06 +++++-<br>
&gt; =C2=A06 files changed, 33 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
&gt; index 0580cd5..4c9067b 100644<br>
&gt; --- a/lib/bb/cooker.py<br>
&gt; +++ b/lib/bb/cooker.py<br>
&gt; @@ -81,7 +81,7 @@ class SkippedPackage:<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0class CookerFeatures(object):<br>
&gt; - =C2=A0 =C2=A0_feature_list =3D [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE]=
 =3D range(2)<br>
&gt; + =C2=A0 =C2=A0_feature_list =3D [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE,=
 BASEDATASTORE_TRACKING] =3D range(3)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0def __init__(self):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._features=3Dset()<br>
&gt; @@ -177,6 +177,9 @@ class BBCooker:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data.disableTracking()<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0def loadConfigurationData(self):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if CookerFeatures.BASEDATASTORE_TRACKING =
in self.featureset:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enableDataTracking()<b=
r>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.initConfigurationData()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.databuilder.parseBaseConfigurat=
ion()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data =3D self.databuilder.data<=
br>
&gt; @@ -189,6 +192,10 @@ class BBCooker:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.data.update_data(self.event_data)=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.parse.init_parser(self.event_data=
)<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if CookerFeatures.BASEDATASTORE_TRACKING =
in self.featureset:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.disableDataTracking()<=
br>
&gt; +<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0def modifyConfigurationVar(self, var, val, default=
_file, op):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if op =3D=3D &quot;append&quot;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.appendConfigurati=
onVar(var, val, default_file)<br>
&gt; @@ -320,7 +327,6 @@ class BBCooker:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open(confpath, &#39;w&#39;).close()<=
br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0def parseConfiguration(self):<br>
&gt; -<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Set log file verbosity<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verboselogs =3D bb.utils.to_boolean(=
self.data.getVar(&quot;BB_VERBOSE_LOGS&quot;, &quot;0&quot;))<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if verboselogs:<br>
&gt; @@ -1175,7 +1181,10 @@ class BBCooker:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D se=
lf.data.getVar(k, True)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not k=
.startswith(&quot;__&quot;) and not isinstance(v, bb.data_smart.DataSmart):=
<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dump[k] =3D { &#39;v&#39; : v }<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dump[k] =3D {<br>
&gt; + =C2=A0 =C2=A0&#39;v&#39; : v ,<br>
&gt; + =C2=A0 =C2=A0&#39;history&#39; : self.data.varhistory.variable(k),<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for d in flaglist:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dump[k][d] =3D self.data.getVarFlag(k, d)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:=
<br>
&gt; diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py<br>
&gt; index e640ed0..1cc7bc2 100644<br>
&gt; --- a/lib/bb/cookerdata.py<br>
&gt; +++ b/lib/bb/cookerdata.py<br>
&gt; @@ -127,6 +127,7 @@ class CookerConfiguration(object):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dump_signatures =3D False<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dry_run =3D False<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.tracking =3D False<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server_only =3D False<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.env =3D {}<br>
&gt;<br>
<br>
</div></div>Patch looks ok in general but I think the above is leftover and=
<br>
unneeded?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Alex D=
amian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div>
</div>

--089e0149c5067d59b604eb359ac0--
