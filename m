Received: from copieur.jabatus.fr (copieur.jabatus.fr [109.234.163.243])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13097.1794490031046933141
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 05:27:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@wenuam.fr header.s=default header.b=xEKU4fqK;
 spf=pass (domain: wenuam.fr, ip: 109.234.163.243, mailfrom: david.koch@wenuam.fr)
X-Spam-Status: No
X-MailPropre-MailScanner-From: david.koch@wenuam.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-25.978, required 5, autolearn=disabled, BAD_PH 0.10,
	HTML_MESSAGE 0.00, MED_SPX 0.80, SPF_HELO_NONE 0.00, SPF_PASS -1.50,
	SUKB_3 0.01, SUKEN_2 0.01, TRACKER_ID 0.10, WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailPropre-MailScanner-ID: D4680E0313.A8F62
X-MailPropre-MailScanner-Information: Please contact the ISP for more information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wenuam.fr;
	s=default; h=In-Reply-To:From:To:References:Subject:MIME-Version:Date:
	Message-ID:Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RGeBRw6jYM2xPu+I7qSV9OWeC40hVu+koZdRre97cJk=; b=xEKU4fqKwg7djCyyGmTM8w904N
	BBo//TdketZCsgfKqB8xy4Gd2XYXhRFpxdb5z3x5YxKs8Do2e+OL+9NdIbxgfnV6cec7kW1RwzeKl
	vmqW36JfnFTVc6nKIr2PSfW4YadZAMxhkfWsy3M5iqaL/8DXZF7af8ZJsJlGOC9i7SYM13Kz1zucr
	HCb7EGzOyXUQaOWIe6s47g91BtkO5Jvk8rewTIozWebijElhF2qFE+Qz2HLg+z90daXU0SvpNw/f2
	nww3eov8b5SGQdh+gqbsspIvEn6Uwa/Rc3QUcj+LT3VB8bqgZ67JEte86L3msTsNE3eClpNn3/0SC
	8jmVnM7Q==;
Content-Type: multipart/alternative;
 boundary="------------PMy6GNXLoAMLubjmDdvhVmAX"
Message-ID: <db07641b-d67e-4f87-a0cb-a704950d7c7a@wenuam.fr>
Date: Thu, 12 Nov 2026 14:26:25 +0100
MIME-Version: 1.0
Subject: [PATCH] bitbake-worker: preserve embedded do_ in task names
Content-Language: fr, en-US
References: <a905add9-4600-4de3-8a3a-02ba3995234d@wenuam.fr>
To: bitbake-devel@lists.openembedded.org
From: WM - David KOCH <david.koch@wenuam.fr>
In-Reply-To: <a905add9-4600-4de3-8a3a-02ba3995234d@wenuam.fr>
X-Forwarded-Message-Id: <a905add9-4600-4de3-8a3a-02ba3995234d@wenuam.fr>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - light.o2switch.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - wenuam.fr
X-Get-Message-Sender-Via: light.o2switch.net: authenticated_id: david.koch@wenuam.fr
X-Authenticated-Sender: light.o2switch.net: david.koch@wenuam.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 13:27:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20422

This is a multi-part message in MIME format.
--------------PMy6GNXLoAMLubjmDdvhVmAX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

I encountered an issue in bin/bitbake-worker when executing custom tasks=20
whose names contain the substring do_.

The worker currently uses:

taskname.replace("do_", "")

to populate BB_CURRENTTASK and construct the process name.

Since str.replace() removes all occurrences, this corrupts valid task=20
names containing do_ internally.

For example:

do_test_pseudo_ownership

becomes:

test_pseuownership

The OE-Core sstate event handler subsequently calls=20
bb.siggen.dump_this_task(), which reconstructs the task name by=20
prepending do_ to BB_CURRENTTASK.

This results in an invalid task name:

do_test_pseuownership

and causes a KeyError during signature generation because that task does=20
not exist in the signature generator's task dependency cache.


*Reproduction*

Define a custom task in a recipe:

fakeroot do_test_pseudo_ownership() {

echo "Testing"

}

do_test_pseudo_ownership[network] =3D "1"

addtask test_pseudo_ownership after do_unpack before do_configure

Then execute:

bitbake recipe-name -c test_pseudo_ownership

The task body executes, but signature generation fails with a KeyError=20
referencing the corrupted task name.


*Proposed fix*

Replace unrestricted str.replace("do_", "") with removal of the leading=20
task prefix only:

taskname[3:]

This preserves embedded occurrences of do_ in both BB_CURRENTTASK and=20
the process name.


*Testing*

  *

    Reproduced the issue with a custom BitBake task in a Yocto build.

  *

    Verified that taskname[3:] produces the expected test_pseudo_ownershi=
p.

  *

    Verified that the patch applies cleanly to the upstream BitBake
    checkout.

The patch is based on upstream revision:

f22df7e0e00be1f3c406138b8b7269d47ea491fe

A dedicated BitBake selftest has not yet been added.


Regards.


Signed-off-by: WM - David KOCH<david.koch@wenuam.fr>
---
  bin/bitbake-worker | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 61484a5c2..0be6f6eba 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,7 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
                  the_data =3D databuilder.mcdata[mc]
                  the_data.setVar("BB_WORKERCONTEXT", "1")
                  the_data.setVar("BB_TASKDEPDATA", taskdepdata)
-                the_data.setVar('BB_CURRENTTASK', taskname.replace("do_"=
, ""))
+                the_data.setVar('BB_CURRENTTASK', taskname[3:])
                  if cfg.limited_deps:
                      the_data.setVar("BB_LIMITEDDEPS", "1")
                  the_data.setVar("BUILDNAME", workerdata["buildname"]) @=
@ -285,7 +285,7 @@ def fork_off_task(cfg, data, databuilder,=20
workerdata, extraconfigdata, runtask): the_data.setVar('BB_UNIHASH',=20
unihash) bb.parse.siggen.setup_datacache_from_datastore(fn, the_data) -=20
bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.repl=
ace("do_", "")))
+                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname[3:]))
 =20
                  if not bb.utils.to_boolean(the_data.getVarFlag(taskname=
, 'network')):
                      if bb.utils.is_local_uid(uid):
-- 2.52.0.windows.1

--=20
WENUAM - M. David KOCH
tel : +33.752.082.083
loc : 12 rue de l'ancienne =C3=A9cole - 86330 LA CHAUSSEE
ent : 909187221 00017 - RCS POITIERS
web :www.wenuam.com

--------------PMy6GNXLoAMLubjmDdvhVmAX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <div class=3D"moz-forward-container">
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"> <span
          lang=3D"en-US">Hello,</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">I encountered an issue in bin/bitbake-worker whe=
n
          executing custom tasks whose names contain the substring do_.</=
span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">The worker currently uses:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">taskname.replace("do_", "")</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">to populate BB_CURRENTTASK and construct the
          process name.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">Since str.replace() removes all occurrences, thi=
s
          corrupts valid task names containing do_ internally.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">For example:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">do_test_pseudo_ownership</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">becomes:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">test_pseuownership</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">The OE-Core sstate event handler subsequently
          calls bb.siggen.dump_this_task(), which reconstructs the task
          name by prepending do_ to BB_CURRENTTASK.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">This results in an invalid task name:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">do_test_pseuownership</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">and causes a KeyError during signature generatio=
n
          because that task does not exist in the signature generator's
          task dependency cache.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><br>
        </span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><b>Reproduction</b></span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">Define a custom task in a recipe:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">fakeroot do_test_pseudo_ownership() {</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"> <span
          lang=3D"en-US">echo "Testing"</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">}</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">do_test_pseudo_ownership[network] =3D "1"</span>=
</p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">addtask test_pseudo_ownership after do_unpack
          before do_configure</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">Then execute:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">bitbake recipe-name -c test_pseudo_ownership</sp=
an></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">The task body executes, but signature generation
          fails with a KeyError referencing the corrupted task name.</spa=
n></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><br>
        </span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><b>Proposed fix</b></span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">Replace unrestricted str.replace("do_", "") with
          removal of the leading task prefix only:</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">taskname[3:]</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">This preserves embedded occurrences of do_ in
          both BB_CURRENTTASK and the process name.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><br>
        </span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><b>Testing</b=
></p>
      <ul>
        <li>
          <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
              lang=3D"en-US">Reproduced the issue with a custom BitBake
              task in a Yocto build.</span></p>
        </li>
        <li>
          <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
              lang=3D"en-US">Verified that taskname[3:] produces the
              expected test_pseudo_ownership.</span></p>
        </li>
        <li>
          <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
              lang=3D"en-US">Verified that the patch applies cleanly to
              the upstream BitBake checkout.</span></p>
        </li>
      </ul>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">The patch is based on upstream revision:</span><=
/p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">f22df7e0e00be1f3c406138b8b7269d47ea491fe</span><=
/p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US">A dedicated BitBake selftest has not yet been
          added.</span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><span
          lang=3D"en-US"><br>
        </span></p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm">Regards.</p>
      <p style=3D"line-height: 116%; margin-bottom: 0.28cm"><br>
      </p>
      <pre wrap=3D"" class=3D"moz-quote-pre">Signed-off-by: WM - David KO=
CH <a
      class=3D"moz-txt-link-rfc2396E" href=3D"mailto:david.koch@wenuam.fr=
"
      moz-do-not-send=3D"true">&lt;david.koch@wenuam.fr&gt;</a>
---
 bin/bitbake-worker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 61484a5c2..0be6f6eba 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,7 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
                 the_data =3D databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
-                the_data.setVar('BB_CURRENTTASK', taskname.replace("do_"=
, ""))
+                the_data.setVar('BB_CURRENTTASK', taskname[3:])
                 if cfg.limited_deps:
                     the_data.setVar("BB_LIMITEDDEPS", "1")
                 the_data.setVar("BUILDNAME", workerdata["buildname<a
      class=3D"moz-txt-link-rfc2396E"
href=3D"mailto:])@@-285,7+285,7@@deffork_off_task(cfg,data,databuilder,wo=
rkerdata,extraconfigdata,runtask):the_data.setVar('BB_UNIHASH',unihash)bb=
.parse.siggen.setup_datacache_from_datastore(fn,the_data)-bb.utils.set_pr=
ocess_name("
      moz-do-not-send=3D"true">"])
@@ -285,7 +285,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
                 the_data.setVar('BB_UNIHASH', unihash)
                 bb.parse.siggen.setup_datacache_from_datastore(fn, the_d=
ata)
=20
-                bb.utils.set_process_name("</a>%s:%s" % (the_data.getVar=
("PN"), taskname.replace("do_", "")))
+                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname[3:]))
=20
                 if not bb.utils.to_boolean(the_data.getVarFlag(taskname,=
 'network')):
                     if bb.utils.is_local_uid(uid):
<div class=3D"moz-txt-sig">--=20
2.52.0.windows.1

</div></pre>
      <pre class=3D"moz-signature" cols=3D"72">--=20
WENUAM - M. David KOCH
tel : +33.752.082.083
loc : 12 rue de l'ancienne =C3=A9cole - 86330 LA CHAUSSEE
ent : 909187221 00017 - RCS POITIERS
web : <a class=3D"moz-txt-link-abbreviated" href=3D"http://www.wenuam.com=
"
      moz-do-not-send=3D"true">www.wenuam.com</a></pre>
    </div>
  </body>
</html>

--------------PMy6GNXLoAMLubjmDdvhVmAX--
