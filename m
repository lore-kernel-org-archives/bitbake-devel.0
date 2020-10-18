Received: from NAM04-BN3-obe.outbound.protection.outlook.com (NAM04-BN3-obe.outbound.protection.outlook.com [40.107.68.87])
 by mx.groups.io with SMTP id smtpd.web12.10980.1602983363746303883
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2020 18:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=oMdYlD4F;
 spf=pass (domain: windriver.com, ip: 40.107.68.87, mailfrom: david.reyna@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ5DazBGJMg6o3jJrIlLWsrQ90YvR9aj/wFGkLwiKt8ZGKa+XsobVIsDNNal0jH5MXkTZs+2BqOJTzXl+VXf5HQZ8PwXCLW4QIV2l1Bu8lzr/MceEPaYRG7eiBTw5UxMAib6atSKrLcrAZmb0CgAmkF6zduZVyFTXtziXKAANihUk6EQnmQhuWcVoCAi32Htyyxm/wBLLEraBPsKoe3I5oODPgWsSDIsFg163gtR0mMIcwM3gBrDjQQRALCOaXG7xfjNhSj9ek621rpXOXIbgjhLyYpp814Bya3Qu15ogIvX7tLlRJVRAVGxuqRNK+24F+Y2Njih+TvYql2lnYLp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tMGs485+84HsliE5Lz7mtMgaBFtp5xXTc07+WTx2Q8=;
 b=SCfAVLi50xK8MhR5iBFo2MpajUya9kEkq6lAME3yaij1ruWoqTJbfRYCjnu0qgftPU96ASr8WwKVU2aUJlboU1mbA2B3B2Q6aureSRwQOk+bHt3glR5Bdth+ORYVm7j6aVV1lbxEEH/T0BXKQETvs37Yvmid5t5GwAyCIYIjdrrtdzFyhmHbuFaINewBJMQh54COz/OtZd54qvjf3x+n3qJM1UJJn2kPkdZHmRQD616ensZ9vOgo/IyZxw3MIW7npGO+Y//EzD3Lc+J+dI62o+sVMgUCi1ekbgpwY6glepH4M83NGmp9g2X+6KRcNqnIKDBsByn2HeU9RLz+VIcwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tMGs485+84HsliE5Lz7mtMgaBFtp5xXTc07+WTx2Q8=;
 b=oMdYlD4Fzqaw9P3nXl8/ydiFmmDpk+YzUkdDrt9gKixjxy5H1aDrKUOKPG7FOnZ9GIY76e0qX6SfBe5j83KR0CgBKRzAg4SMtWj2QpulBhcflHOMumHHxguklpdh/qcO8xv17RgvUuARsF+KSyVyPrnFxwXVlJay0DZM8rGSChQ=
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Sun, 18 Oct
 2020 01:09:20 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::a567:83cb:6eae:d661]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::a567:83cb:6eae:d661%6]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 01:09:20 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Tim Orling <ticotimo@gmail.com>
Subject: [bitbake-devel] [PATCH] toaster: Update documentation links to new URLs
Thread-Topic: [bitbake-devel] [PATCH] toaster: Update documentation links to
 new URLs
Thread-Index: Adak6wrepBjevnpxS2KqnwcnChhEwg==
Date: Sun, 18 Oct 2020 01:09:20 +0000
Message-ID: 
 <BY5PR11MB4167C3D24982FAC243C80942EA010@BY5PR11MB4167.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [2601:646:4201:e280:c9a:908f:b687:7754]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c12ba56-63a7-4f8e-a65f-08d8730271cb
x-ms-traffictypediagnostic: BYAPR11MB3141:
x-microsoft-antispam-prvs: 
 <BYAPR11MB3141408CE5F0B9E7D07E714AEA010@BYAPR11MB3141.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZmHt4fR0CQtRWaw2pAdOOUm6NGCju3oziUbo278bpPvCdHZn+s7lndQLMT+kGVr6tFMzog0CoFahPZNvlc5IAM5ZV7SkWLZ7C3L//Kxos7V0DXrYC6WAN6KvN/WvzzWaLCK+9qf3l3rPjU9I6w3OCTr/RY50po4xVAZhLQf5EWTQEmBcutNW7wq32m4+Ide1ZoWk6sKzjeMUIcP8eUXjs3BIh9oJx+qENRqKZOSLAxYQRq+l00FKMvl1pp+iA3O2c2YRrZHJ4acn8VAAFWmFey0QxKOgI2r70L/rBRAVPzQXZBsQEtz5cm6jqOx9ZZUJSbBewOARcmE27ZTZhcar5F4pE+61XJlpos8k8XZiZHhhGRXuIAct4QvhVMAIN7cQsGs3HJ//DyFnMWj2A6GTeA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39830400003)(136003)(396003)(7696005)(166002)(316002)(4326008)(478600001)(86362001)(21615005)(55016002)(52536014)(71200400001)(66446008)(33656002)(2906002)(66556008)(66476007)(9686003)(6506007)(186003)(64756008)(66946007)(7066003)(83380400001)(76116006)(8676002)(15650500001)(8936002)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 qQCyb4E8D5rBXlpIqJW1f4uyB4y3BX2xpmRBAnBCAxpjnIBDGfzj65Eq9knKLGq/ZAjQmQ75WcwppG5oYxK5oloHU28ZCTwe7PDYyLGCapNJZVGPcmdAk9opmPeT7+nTFU+DgQ85pnH0ZFDHyBnSCNOBzQw6hkXVg+Q9A9O/SZxY3E7ocYvVAaI7NuEtKc0ldM9MXpomEPKj0sm3meAevmz7KMa+VL52i04kVUE3xVUI9cmfKk0+uG9yQRVFW+1gYEC4Upau56TA66MTmV0SvQDFhQj1x3aBr4mPxVK03CRoVQQQNchqzpIojabmAjmI9DNL6Q95cIo5s0w5AjTvT7m7Alu8h9wVYw4E7xXIyqEyGe2KFkSqryt2/rME3c4+4s7ECrb+jqIvRh3nI015uXUEHZ9buo1bUqN1P/izEldHgXOrleyp/DCiM8WxlSzTVHsCga313KgzTDxpZ5U59J7sc/xUvLoizHN/5ebSVfTDiu32Gjco5R3y0N2HUFjKMRJ0IUCV/bwt6W6+uPWpN98Q5QowvUkddx80YWNqKkqKTFRCVNWYDbwAYaIX8lG8tFEuhNko3k/Crkxaq+PeTpOFD9FE3mMVLZ2xa3usqlt92FEFEv6UasxeBEDZ2qU5DXumaQb+Xzf6gYtS5ZsYZjj6cQac+18jqmoM6htipMJ6NvpcYQtNzTfg/iw0AQ+OcxS1I369C7PouMyPkJu/vA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c12ba56-63a7-4f8e-a65f-08d8730271cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2020 01:09:20.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdqM++nqmkjuM9cJsORuNfF3r6mtU3tvJRQ8g1y/MKoC40Q0YetNSKbEPJ0B7vMCye73HfGTWEqj5aEDsst7K+Y4g5ODpQOYqKekqThCXe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3141
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Update the Toaster documentation links to the new
Yocto Project URLs.

[YOCTO #14092]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/base.html                | 2 +-
 lib/toaster/toastergui/templates/configvars.html          | 2 +-
 lib/toaster/toastergui/templates/landing.html             | 8 ++++----
 lib/toaster/toastergui/templates/landing_not_managed.html | 2 +-
 lib/toaster/toastergui/templates/project.html             | 2 +-
 lib/toaster/toastergui/templates/project_specific.html    | 2 +-
 lib/toaster/toastergui/templates/projectconf.html         | 8 ++++----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toast=
ergui/templates/base.html
index 4f7206489b..9e19cc33ca 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -123,7 +123,7 @@
               {% endif %}
             {% endif %}
               <li id=3D"navbar-docs">
-              <a target=3D"_blank" href=3D"http://www.yoctoproject.org/doc=
s/latest/toaster-manual/toaster-manual.html">
+              <a target=3D"_blank" href=3D"https://www.yoctoproject.org/do=
cs/latest/toaster-manual/toaster-manual.html">
                 <i class=3D"glyphicon glyphicon-book"></i>
                 Documentation
               </a>
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster=
/toastergui/templates/configvars.html
index ca2e1eab39..33fef9316d 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -66,7 +66,7 @@
         <td class=3D"description">
             {% if variable.description %}
                 {{variable.description}}
-                <a href=3D"http://www.yoctoproject.org/docs/current/ref-ma=
nual/ref-manual.html#var-{{variable.variable_name|variable_parent_name}}" t=
arget=3D"_blank">
+                <a href=3D"https://www.yoctoproject.org/docs/current/ref-m=
anual/ref-manual.html#var-{{variable.variable_name|variable_parent_name}}" =
target=3D"_blank">
                 <span class=3D"glyphicon glyphicon-new-window get-info"></=
span></a>
             {% endif %}
         </td>
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/to=
astergui/templates/landing.html
index 70c7359fad..bfaaf6fc83 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -12,10 +12,10 @@
             <div class=3D"col-md-6">
               <h1>This is Toaster</h1>
=20
-              <p>A web interface to <a href=3D"http://www.openembedded.org=
">OpenEmbedded</a> and <a href=3D"http://www.yoctoproject.org/tools-resourc=
es/projects/bitbake">BitBake</a>, the <a href=3D"http://www.yoctoproject.or=
g">Yocto Project</a> build system.</p>
+              <p>A web interface to <a href=3D"https://www.openembedded.or=
g">OpenEmbedded</a> and <a href=3D"https://www.yoctoproject.org/tools-resou=
rces/projects/bitbake">BitBake</a>, the <a href=3D"https://www.yoctoproject=
.org">Yocto Project</a> build system.</p>
=20
 		          <p class=3D"top-air">
-		            <a class=3D"btn btn-info btn-lg" href=3D"http://www.yoctopro=
ject.org/docs/latest/toaster-manual/toaster-manual.html#toaster-manual-setu=
p-and-use">
+		            <a class=3D"btn btn-info btn-lg" href=3D"https://www.yoctopr=
oject.org/docs/latest/toaster-manual/toaster-manual.html#toaster-manual-set=
up-and-use">
 			            Toaster is ready to capture your command line builds
 		            </a>
 		          </p>
@@ -33,7 +33,7 @@
                   Toaster has no layer information. Without layer informat=
ion, you cannot run builds. To generate layer information you can:
                   <ul>
                     <li>
-                      <a href=3D"http://www.yoctoproject.org/docs/latest/t=
oaster-manual/toaster-manual.html#layer-source">Configure a layer source</a=
>
+                      <a href=3D"https://www.yoctoproject.org/docs/latest/=
toaster-manual/toaster-manual.html#layer-source">Configure a layer source</=
a>
                     </li>
                     <li>
 			                <a href=3D"{% url 'newproject' %}">Create a project</a>=
, then import layers
@@ -44,7 +44,7 @@
=20
               <ul class=3D"list-unstyled lead">
                 <li>
-                  <a href=3D"http://www.yoctoproject.org/docs/latest/toast=
er-manual/toaster-manual.html">
+                  <a href=3D"https://www.yoctoproject.org/docs/latest/toas=
ter-manual/toaster-manual.html">
                     Read the Toaster manual
                   </a>
                 </li>
diff --git a/lib/toaster/toastergui/templates/landing_not_managed.html b/li=
b/toaster/toastergui/templates/landing_not_managed.html
index baa4b72c14..e7200b8412 100644
--- a/lib/toaster/toastergui/templates/landing_not_managed.html
+++ b/lib/toaster/toastergui/templates/landing_not_managed.html
@@ -20,7 +20,7 @@
      <p">
      The 'Build' mode allows you to configure and run your Yocto Project b=
uilds from Toaster.
      <ul>
-       <li><a href=3D"http://www.yoctoproject.org/docs/latest/toaster-manu=
al/toaster-manual.html#intro-modes">
+       <li><a href=3D"https://www.yoctoproject.org/docs/latest/toaster-man=
ual/toaster-manual.html#intro-modes">
        Read about the 'Build' mode
        </a></li>
        <li><a href=3D"/">
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/to=
astergui/templates/project.html
index fa41e3c909..d8ad2c79dc 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -139,7 +139,7 @@
         <ul>
           <li><a href=3D"{% url 'projectlayers' project.id %}">Choose from=
 the layers compatible with this project</a></li>
           <li><a href=3D"{% url 'importlayer' project.id %}">Import a laye=
r</a></li>
-          <li><a href=3D"http://www.yoctoproject.org/docs/current/dev-manu=
al/dev-manual.html#understanding-and-creating-layers" target=3D"_blank">Rea=
d about layers in the documentation</a></li>
+          <li><a href=3D"https://www.yoctoproject.org/docs/current/dev-man=
ual/dev-manual.html#understanding-and-creating-layers" target=3D"_blank">Re=
ad about layers in the documentation</a></li>
           <li>Or type a layer name below</li>
         </ul>
       </div>
diff --git a/lib/toaster/toastergui/templates/project_specific.html b/lib/t=
oaster/toastergui/templates/project_specific.html
index f625d18baf..42725c0dba 100644
--- a/lib/toaster/toastergui/templates/project_specific.html
+++ b/lib/toaster/toastergui/templates/project_specific.html
@@ -137,7 +137,7 @@
         <ul>
           <li><a href=3D"{% url 'projectlayers' project.id %}">Choose from=
 the layers compatible with this project</a></li>
           <li><a href=3D"{% url 'importlayer' project.id %}">Import a laye=
r</a></li>
-          <li><a href=3D"http://www.yoctoproject.org/docs/current/dev-manu=
al/dev-manual.html#understanding-and-creating-layers" target=3D"_blank">Rea=
d about layers in the documentation</a></li>
+          <li><a href=3D"https://www.yoctoproject.org/docs/current/dev-man=
ual/dev-manual.html#understanding-and-creating-layers" target=3D"_blank">Re=
ad about layers in the documentation</a></li>
           <li>Or type a layer name below</li>
         </ul>
       </div>
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaste=
r/toastergui/templates/projectconf.html
index fb20b26f22..bd49f1f585 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -201,12 +201,12 @@
           <p>Toaster cannot set any variables that impact 1) the configura=
tion of the build servers,
           or 2) where artifacts produced by the build are stored. Such var=
iables include: </p>
           <p>
-          <code><a href=3D"http://www.yoctoproject.org/docs/1.6.1/ref-manu=
al/ref-manual.html#var-BB_DISKMON_DIRS" target=3D"_blank">BB_DISKMON_DIRS</=
a></code>
-          <code><a href=3D"http://www.yoctoproject.org/docs/1.6.1/ref-manu=
al/ref-manual.html#var-BB_NUMBER_THREADS" target=3D"_blank">BB_NUMBER_THREA=
DS</a></code>
+          <code><a href=3D"https://www.yoctoproject.org/docs/current/ref-m=
anual/ref-manual.html#var-BB_DISKMON_DIRS" target=3D"_blank">BB_DISKMON_DIR=
S</a></code>
+          <code><a href=3D"https://www.yoctoproject.org/docs/current/ref-m=
anual/ref-manual.html#var-BB_NUMBER_THREADS" target=3D"_blank">BB_NUMBER_TH=
READS</a></code>
           <code>CVS_PROXY_HOST</code>
           <code>CVS_PROXY_PORT</code>
-          <code><a href=3D"http://www.yoctoproject.org/docs/1.6.1/ref-manu=
al/ref-manual.html#var-PARALLEL_MAKE" target=3D"_blank">PARALLEL_MAKE</a></=
code>
-          <code><a href=3D"http://www.yoctoproject.org/docs/1.6.1/ref-manu=
al/ref-manual.html#var-TMPDIR" target=3D"_blank">TMPDIR</a></code></p>
+          <code><a href=3D"https://www.yoctoproject.org/docs/current/ref-m=
anual/ref-manual.html#var-PARALLEL_MAKE" target=3D"_blank">PARALLEL_MAKE</a=
></code>
+          <code><a href=3D"https://www.yoctoproject.org/docs/current/ref-m=
anual/ref-manual.html#var-TMPDIR" target=3D"_blank">TMPDIR</a></code></p>
           <p>Plus the following standard shell environment variables:</p>
           <p><code>http_proxy</code> <code>ftp_proxy</code> <code>https_pr=
oxy</code> <code>all_proxy</code></p>
         </div>
--=20
2.17.1

