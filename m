Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <oren@ephemeron-labs.com>) id 1S1o0X-0006gr-MY
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 01:00:02 +0100
Received: by obhx4 with SMTP id x4so4993291obh.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 15:51:35 -0800 (PST)
Received-SPF: pass (google.com: domain of oren@ephemeron-labs.com designates
	10.60.20.6 as permitted sender) client-ip=10.60.20.6; 
Authentication-Results: mr.google.com; spf=pass (google.com: domain of
	oren@ephemeron-labs.com designates 10.60.20.6 as permitted
	sender) smtp.mail=oren@ephemeron-labs.com
Received: from mr.google.com ([10.60.20.6])
	by 10.60.20.6 with SMTP id j6mr4065087oee.17.1330300295690 (num_hops =
	1); Sun, 26 Feb 2012 15:51:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.60.20.6 with SMTP id j6mr3625843oee.17.1330300295583; Sun, 26
	Feb 2012 15:51:35 -0800 (PST)
Received: by 10.182.14.231 with HTTP; Sun, 26 Feb 2012 15:51:35 -0800 (PST)
X-Originating-IP: [76.99.59.229]
Date: Sun, 26 Feb 2012 18:51:35 -0500
Message-ID: <CALvD2LjQx6M222rdd754cTZtx+fohvxC57+Efx3d=PF9YoNGXw@mail.gmail.com>
From: Oren Leaffer <oren@ephemeron-labs.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQntODaE9vg+mBFCiHxxSkO82H2zgNup/wKtfswle+GWtsCvaPYg+Q+m4FuorBKGfGdikyGW
Subject: getting started (well, trying to)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 27 Feb 2012 00:00:02 -0000
Content-Type: multipart/alternative; boundary=e89a8fb2070c90168804b9e6acc4

--e89a8fb2070c90168804b9e6acc4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry if this is the wrong list to direct this question, but I'm having
a hard time getting bitbake/openembedded building anything.

Right now, "bitbake nano" fails with the error "ERROR: Unable to parse
/home/ol/openem/openembedded/recipes/wmiconfig/wmiconfig_svn.bb " and then
gives some more details that are at the end of this message.

What branch of bitbake and openembedded should I be on? I've been trying
this all day and I can find several sets of mutually contradictory
instructions, is there an authoritative one?



Thanks,


Oren


~/openem/build$ bitbake nano
Pseudo is not present but is required, building this first before the main
build
ERROR: Unable to parse /home/ol/openem/openembedded/recipes/wmiconfig/
wmiconfig_svn.bb                            | ETA:  --:--:--
Traceback (most recent call last):
  File "/home/ol/setup-scripts/sources/bitbake/lib/bb/utils.py", line 387,
in
simple_exec(code=3D'__anon_185__home_ol_openem_openembedded_classes_staging=
_bbclass(d)\n__anon_90__home_ol_openem_openembedded_classes_packaged_stagin=
g_bbclass(d)\n__anon_419__home_ol_openem_openembedded_classes_base_bbclass(=
d)\n__anon_38__home_ol_openem_openembedded_classes_src_distribute_local_bbc=
lass(d)\n__anon_19__home_ol_openem_openembedded_classes_angstrom_blacklist_=
bbclass(d)\n__anon_148__home_ol_openem_openembedded_classes_package_bbclass=
(d)\n__anon_311__home_ol_openem_openembedded_classes_package_ipk_bbclass(d)=
',
context=3D{'d': <bb.data_smart.DataSmart object at 0x21d29d0>}):
     def simple_exec(code, context):
    >    exec(code, _context, context)

  File "<string>", line 3, in <module>
  File "__anon_419__home_ol_openem_openembedded_classes_base_bbclass", line
76, in
__anon_419__home_ol_openem_openembedded_classes_base_bbclass(d=3D<bb.data_s=
mart.DataSmart
object at 0x21d29d0>)
  File "base.bbclass", line 11, in
set_multimach_arch(d=3D<bb.data_smart.DataSmart object at 0x21d29d0>)
  File "utils.bbclass", line 4, in
is_machine_specific(d=3D<bb.data_smart.DataSmart object at 0x21d29d0>)
AttributeError: 'module' object has no attribute 'init'

ERROR: Command execution failed: Exited with 1

Summary: There was 1 ERROR message shown, returning a non-zero exit code.

--e89a8fb2070c90168804b9e6acc4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I&#39;m sorry if this is the wrong list to direct th=
is question, but I&#39;m having a hard time getting bitbake/openembedded bu=
ilding anything.</div><div><br></div><div>Right now, &quot;bitbake nano&quo=
t; fails with the error &quot;ERROR: Unable to parse /home/ol/openem/openem=
bedded/recipes/wmiconfig/<a href=3D"http://wmiconfig_svn.bb">wmiconfig_svn.=
bb</a> &quot; and then gives some more details that are at the end of this =
message.</div>
<div><br></div><div>What branch of bitbake and openembedded should I be on?=
 I&#39;ve been trying this all day and I can find several sets of mutually =
contradictory instructions, is there an=A0authoritative=A0one?</div><div><b=
r>
</div><div><br></div><div><br></div><div>Thanks,</div><div><br></div><div><=
br></div><div>Oren</div><div><br></div><div><br></div><div><div>~/openem/bu=
ild$ bitbake nano</div><div>Pseudo is not present but is required, building=
 this first before the main build</div>
<div>ERROR: Unable to parse /home/ol/openem/openembedded/recipes/wmiconfig/=
<a href=3D"http://wmiconfig_svn.bb">wmiconfig_svn.bb</a> =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| ETA: =A0--:--:--</div><div>Traceba=
ck (most recent call last):</div>
<div>=A0 File &quot;/home/ol/setup-scripts/sources/bitbake/lib/bb/utils.py&=
quot;, line 387, in simple_exec(code=3D&#39;__anon_185__home_ol_openem_open=
embedded_classes_staging_bbclass(d)\n__anon_90__home_ol_openem_openembedded=
_classes_packaged_staging_bbclass(d)\n__anon_419__home_ol_openem_openembedd=
ed_classes_base_bbclass(d)\n__anon_38__home_ol_openem_openembedded_classes_=
src_distribute_local_bbclass(d)\n__anon_19__home_ol_openem_openembedded_cla=
sses_angstrom_blacklist_bbclass(d)\n__anon_148__home_ol_openem_openembedded=
_classes_package_bbclass(d)\n__anon_311__home_ol_openem_openembedded_classe=
s_package_ipk_bbclass(d)&#39;, context=3D{&#39;d&#39;: &lt;bb.data_smart.Da=
taSmart object at 0x21d29d0&gt;}):</div>
<div>=A0 =A0 =A0def simple_exec(code, context):</div><div>=A0 =A0 &gt; =A0 =
=A0exec(code, _context, context)</div><div>=A0 =A0 =A0</div><div>=A0 File &=
quot;&lt;string&gt;&quot;, line 3, in &lt;module&gt;</div><div>=A0 File &qu=
ot;__anon_419__home_ol_openem_openembedded_classes_base_bbclass&quot;, line=
 76, in __anon_419__home_ol_openem_openembedded_classes_base_bbclass(d=3D&l=
t;bb.data_smart.DataSmart object at 0x21d29d0&gt;)</div>
<div>=A0 File &quot;base.bbclass&quot;, line 11, in set_multimach_arch(d=3D=
&lt;bb.data_smart.DataSmart object at 0x21d29d0&gt;)</div><div>=A0 File &qu=
ot;utils.bbclass&quot;, line 4, in is_machine_specific(d=3D&lt;bb.data_smar=
t.DataSmart object at 0x21d29d0&gt;)</div>
<div>AttributeError: &#39;module&#39; object has no attribute &#39;init&#39=
;</div><div><br></div><div>ERROR: Command execution failed: Exited with 1</=
div><div><br></div><div>Summary: There was 1 ERROR message shown, returning=
 a non-zero exit code.</div>
</div><div><br></div>

--e89a8fb2070c90168804b9e6acc4--
