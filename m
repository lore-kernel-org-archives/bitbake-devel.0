Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
Received: from SRV-MSX01.digitendos.local
	(host-80-81-19-29.customer.m-online.net [80.81.19.29])
	by mail.openembedded.org (Postfix) with ESMTP id 368F06D383
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Oct 2013 16:28:20 +0000 (UTC)
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Tue, 29 Oct 2013 17:28:19 +0100
Message-ID: <526FE221.5070909@digitalendoscopy.de>
Date: Tue, 29 Oct 2013 17:28:17 +0100
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.000.1014-20254.006
X-TM-AS-Result: No--15.080200-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Subject: HG Fetch with username and password in url
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
X-List-Received-Date: Tue, 29 Oct 2013 16:28:21 -0000
X-Groupsio-MsgNum: 4048
Content-Type: multipart/mixed; boundary="------------050004000607010200030108"

--------------050004000607010200030108
Content-Type: multipart/alternative;
	boundary="------------000502050205030404010901"

--------------000502050205030404010901
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

We currently use an company internal mercurial server with username and 
password authentication
that will be accessed during the build of a firmware image from within a 
custom recipe.
The only way to access it from within the yocto toolchain seems to have 
the username and password
stored within the URL of the SRC_URI variable.

But the current hg.py fetcher does not completely support this. Attached 
is a patch that fixes the missing parts.
-- 

*Volker Vogelhuber*| Softwareentwickler

*PENTAX**MEDICA**L
*/Excellence in Focus//^TM /

Tel: +49(0)821-650566-18
v.vogelhuber@DigitalEndoscopy.de <mailto:v.vogelhuber@DigitalEndoscopy.de>

Hoya Corporation - Pentax Medical Division
*Digital**Endoscopy GmbH*
Paul-Lenz-Str. 5
86316 Friedberg - Germany
pentaxmedical.com
Handelsregister HRB 27226
Amtsgericht Augsburg
Geschäftsführer: Michael Drexel, Marc Henzler
Sitz: Paul-Lenz-Str. 5, 86316 Friedberg, Germany

_____________________________________

Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte 
Informationen. Wenn Sie nicht der richtige Adressat sind oder diese 
E-Mail irrtümlich erhalten haben, informieren Sie bitte sofort den 
Absender und vernichten Sie diese Mail. Das unerlaubte Kopieren sowie 
die unbefugte Weitergabe dieser Mail ist nicht gestattet.
This e-mail may contain confidential and/or privileged information. If 
you are not the intended recipient (or have received this e-mail in 
error) please notify the sender immediately and destroy this e-mail. Any 
unauthorized copying, disclosure or distribution of the material in this 
e-mail is strictly forbidden.


--------------000502050205030404010901
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    We currently use an company internal mercurial server with username
    and password authentication<br>
    that will be accessed during the build of a firmware image from
    within a custom recipe.<br>
    The only way to access it from within the yocto toolchain seems to
    have the username and password<br>
    stored within the URL of the SRC_URI variable. <br>
    <br>
    But the current hg.py fetcher does not completely support this.
    Attached is a patch that fixes the missing parts.<br>
    <div class="moz-signature">-- <br>
      <!-- <head> -->
      <!--   <meta content="text/html; " http-equiv="content-type"> -->
      <!--   <title></title> -->
      <!-- </head> -->
      <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
            lang="DE">Volker Vogelhuber</span></b><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="DE"> | Softwareentwickler</span></p>
      <p class="MsoNormal"><b><span
            style="font-size:12.0pt;font-family:'serif';color:#DA291C"
            lang="DE">PENTAX</span></b><b><span
            style="font-size:12.0pt;font-family:'serif';color:#53565A"
            lang="DE"> MEDICA</span></b><b><span
            style="font-family:'serif';color:#53565A;font-size:12.0pt;">L<br>
          </span></b><i><span
            style="font-size:12.0pt;font-family:'serif';color:#53565A">Excellence

            in Focus</span></i><i><sup><span
              style="font-size:8.0pt;font-family:'serif';color:#53565A">TM</span></sup></i><span
style="font-size:7.0pt;font-family:'Arial','sans-serif';color:#1F497D;mso-fareast-language:DE"
          lang="EN-GB"><o:p></o:p></span></p>
      <p class="MsoNormal"><span
style="font-size:9.0pt;font-family:'Arial','sans-serif';color:red;mso-fareast-language:DE"
          lang="EN-GB">Tel:&nbsp; </span><span
style="font-size:9.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB">+49(0)821-650566-</span><span
style="font-size:9.0pt;font-family:'Arial','sans-serif';color:#1F497D;mso-fareast-language:DE"
          lang="EN-GB">18</span><span
style="font-size:12.0pt;font-family:'serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB"><o:p></o:p></span><br>
        <span
style="font-size:9.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB"><a href="mailto:v.vogelhuber@DigitalEndoscopy.de"><span
              style="color:#404040;text-decoration:none" lang="EN-US">v.vogelhuber@DigitalEndoscopy.de</span></a><o:p></o:p></span></p>
      <p class="MsoNormal"><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB">Hoya Corporation - Pentax Medical Division</span><br>
        <b><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
            lang="EN-GB">Digital</span></b><b><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
            lang="EN-GB"> Endoscopy GmbH<o:p></o:p></span></b><span
style="font-size:9.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB"><br>
          Paul-Lenz-Str. 5<o:p></o:p><br>
          86316 Friedberg - Germany<o:p></o:p></span><span
          style="font-family:'serif';color:#E70600;mso-fareast-language:JA"><br>
          pentax</span><span
          style="font-family:'serif';color:#0D2531;mso-fareast-language:JA">medical.com</span><span
style="font-size:5.0pt;font-family:'Arial','sans-serif';color:#1F497D;mso-fareast-language:DE"><o:p></o:p></span><span
style="font-size:8.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="DE"><br>
          Handelsregister HRB 27226<o:p></o:p><br>
          Amtsgericht Augsburg<o:p></o:p><br>
          Gesch&auml;ftsf&uuml;hrer: Michael Drexel, Marc Henzler<o:p></o:p><br>
          Sitz: Paul-Lenz-Str. 5, 86316 Friedberg, Germany</span><span
style="font-size:8.0pt;font-family:'Arial','sans-serif';color:#1F497D;mso-fareast-language:DE"
          lang="DE"><o:p></o:p></span> </p>
      <p class="MsoNormal"><span
style="font-size:8.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="DE"><o:p>&nbsp;</o:p></span><span
style="font-size:10.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="DE">_____________________________________<o:p></o:p></span><span
style="font-size:8.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="DE"><o:p>&nbsp;</o:p></span> </p>
      <p class="MsoNormal"><span
style="font-size:8.0pt;font-family:'Arial','sans-serif';color:#404040;mso-fareast-language:DE"
          lang="EN-GB">Diese E-Mail enth&auml;lt vertrauliche und/oder
          rechtlich gesch&uuml;tzte Informationen. Wenn Sie nicht der
          richtige Adressat sind oder diese E-Mail irrt&uuml;mlich erhalten
          haben, informieren Sie bitte sofort den Absender und
          vernichten Sie diese Mail. Das unerlaubte Kopieren sowie die
          unbefugte Weitergabe dieser Mail ist nicht gestattet.<br>
          This e-mail may contain confidential and/or privileged
          information. If you are not the intended recipient (or have
          received this e-mail in error) please notify the sender
          immediately and destroy this e-mail. Any unauthorized copying,
          disclosure or distribution of the material in this e-mail is
          strictly forbidden.</span><span
          style="color:#404040;mso-fareast-language:DE" lang="EN-GB"><o:p></o:p></span></p>
      <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
    </div>
  </body>
</html>

--------------000502050205030404010901--

--------------050004000607010200030108
Content-Type: text/x-patch; name="hg_with_user_name_and_passwd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hg_with_user_name_and_passwd.patch"

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index b1c8675..cf21481 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -92,7 +92,10 @@ class Hg(FetchMethod):
         if not ud.user:
             hgroot = host + ud.path
         else:
-            hgroot = ud.user + "@" + host + ud.path
+            if ud.pswd:
+                hgroot = ud.user + ":" + ud.pswd + "@" + host + ud.path
+            else:
+                hgroot = ud.user + "@" + host + ud.path
 
         if command == "info":
             return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot, ud.module)
@@ -112,7 +115,10 @@ class Hg(FetchMethod):
             # do not pass options list; limiting pull to rev causes the local
             # repo not to contain it and immediately following "update" command
             # will crash
-            cmd = "%s pull" % (basecmd)
+            if ud.user and ud.pswd:
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (basecmd, ud.user, ud.pswd, proto)
+            else:
+                cmd = "%s pull" % (basecmd)
         elif command == "update":
             cmd = "%s update -C %s" % (basecmd, " ".join(options))
         else:

--------------050004000607010200030108--
