Return-Path: <elliot.smith@intel.com>
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
	[209.85.161.170])
	by mail.openembedded.org (Postfix) with ESMTP id 529316FF0E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 09:20:02 +0000 (UTC)
Received: by mail-yw0-f170.google.com with SMTP id r9so69273028ywg.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=rdxoTn8JRw1Hj2b3CffN24XDVQk6d8T5ty9wsxC9Yy0=;
	b=alqNrHjCTxLTGuBKMpqigZN3wbSl5Xxth6ODY+El4JPDg+c5FPtvapLldqQr4LH6uq
	nCey46qh2QcALFKRqJboAJ9d3VCGRAbHMKI0j5YaLDrq9mW9pJKw/2tJxH1YfhzxxHSm
	MNq/2S+fBjuilkdPovXvOFk5wbUAy9pGMW06iBsHpoYALSsRPCOXBfgdBdQaRVYTN540
	RWhGok9Zr1zGDl2McrekOXetmY8EWHSOfeQHbFSCg1k4YjklodlrmKoIsNvvpWzbhsIP
	cBXXnJj3dutf1ALkd49msFYiqO//QQ165wZfMr3pXNxKMyQjUDnetzEjuLzXnh7m6VT6
	l8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=rdxoTn8JRw1Hj2b3CffN24XDVQk6d8T5ty9wsxC9Yy0=;
	b=B59Y5Ct/EdA9ifF0cV0Ady3sFHxfcsjlSnL9dhl4KzBLQnLJhJUuppMmgXnILOG9Tp
	x7XNFoviZvAXzv9wBtC++iFytmGj5f6oEbWzvDRk0/mnrn8qUiZO6R+HUBpfDizO6bYi
	+LazahBVI9rw3PNewwlaMoFkSXyGrQsUjSDO0mI2uEXJ2salDURXNgnEFfcWpcDxvpEF
	7got9T9N5fl0q+Nggd4xOf7nK3Xa+WahibS6gzUnmgPl7BvuUjYtVCTbC3/pQXZBZdKl
	3GPA7IXQ2YvXsAZ0Dp5MG72BvIwbsEZAvajzIYSwiUucZF9utug3be5+nGRqP6lbHN9p
	9S8g==
X-Gm-Message-State: ALyK8tIcVMGetguXFf+8Z+tgaZHKNvZvNBIhayp3aVP5auGJmPgfTKyQLOb9YyJcCyIghbd1C86i3HGcKIeeZjOC
X-Received: by 10.37.208.76 with SMTP id h73mr14295157ybg.85.1469092803520;
	Thu, 21 Jul 2016 02:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.111.5 with HTTP; Thu, 21 Jul 2016 02:20:02 -0700 (PDT)
In-Reply-To: <578F9EEE.9000708@intel.com>
References: <1466185971-18537-1-git-send-email-michael.g.wood@intel.com>
	<1466185971-18537-2-git-send-email-michael.g.wood@intel.com>
	<578F9EEE.9000708@intel.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
Date: Thu, 21 Jul 2016 10:20:02 +0100
Message-ID: <CA+1hgUjP57xJ1WH-4z8syjMps_gLZFoeWnOM4H2ggZkQ_YiQfw@mail.gmail.com>
To: Michael Wood <michael.g.wood@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] toaster-tests: define capabilities for latest Firefox driver
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
X-List-Received-Date: Thu, 21 Jul 2016 09:20:03 -0000
Content-Type: multipart/alternative; boundary=94eb2c05610eb26253053821d2ea

--94eb2c05610eb26253053821d2ea
Content-Type: text/plain; charset=UTF-8

On 20 July 2016 at 16:55, Michael Wood <michael.g.wood@intel.com> wrote:

> On 17/06/16 18:52, Michael Wood wrote:
>
>> From: Elliot Smith <elliot.smith@intel.com>
>>
>> For the latest Firefox versions, WebDriver requires a download of a
>> separate binary and an additional capability to be defined on it.
>>
>> Modify our tests so that when "marionette" is set as the browser,
>> this capability is defined on the Firefox driver. Also add a note to the
>> README about the additional installation steps required.
>>
>
Note that I resubmitted a rebased version of these patches, as changes on
toaster-next mean that this version won't apply.

Elliot



>
>> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
>> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
>> ---
>>   lib/toaster/tests/browser/README              | 19 +++++++++++++++++--
>>   lib/toaster/tests/browser/selenium_helpers.py |  5 +++++
>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/toaster/tests/browser/README
>> b/lib/toaster/tests/browser/README
>> index f57154e..969f06c 100644
>> --- a/lib/toaster/tests/browser/README
>> +++ b/lib/toaster/tests/browser/README
>> @@ -24,15 +24,30 @@ To run tests against PhantomJS (headless):
>>   * On *nix systems, put phantomjs on PATH
>>   * Not tested on Windows
>>   -Firefox should work without requiring additional software to be
>> installed.
>> +To run tests against Firefox, you may need to install the Marionette
>> driver,
>> +depending on how new your version of Firefox is. One clue that you need
>> to do
>> +this is if you see an exception like:
>>   -The test case will instantiate a Selenium driver set by the
>> +  selenium.common.exceptions.WebDriverException: Message: The browser
>> +  appears to have exited before we could connect. If you specified
>> +  a log_file in the FirefoxBinary constructor, check it for details.
>> +
>> +See
>> https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette/WebDriver
>> +for installation instructions. Ensure that the Marionette executable
>> (renamed
>> +as wires on Linux or wires.exe on Windows) is on your PATH; and use
>> "marionette"
>> +as the browser string passed via TOASTER_TESTS_BROWSER (see below).
>> +
>> +(Note: The Toaster tests have been checked against Firefox 47 with the
>> +Marionette driver.)
>> +
>> +The test cases will instantiate a Selenium driver set by the
>>   TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not
>> specified.
>>     Available drivers:
>>     * chrome (default)
>>   * firefox
>> +* marionette (for newer Firefoxes)
>>   * ie
>>   * phantomjs
>>   diff --git a/lib/toaster/tests/browser/selenium_helpers.py
>> b/lib/toaster/tests/browser/selenium_helpers.py
>> index 54db2e8..000937f 100644
>> --- a/lib/toaster/tests/browser/selenium_helpers.py
>> +++ b/lib/toaster/tests/browser/selenium_helpers.py
>> @@ -34,6 +34,7 @@ import time
>>   from django.contrib.staticfiles.testing import StaticLiveServerTestCase
>>   from selenium import webdriver
>>   from selenium.webdriver.support.ui import WebDriverWait
>> +from selenium.webdriver.common.desired_capabilities import
>> DesiredCapabilities
>>   from selenium.common.exceptions import NoSuchElementException, \
>>           StaleElementReferenceException, TimeoutException
>>   @@ -49,6 +50,10 @@ def create_selenium_driver(browser='chrome'):
>>           )
>>       elif browser == 'firefox':
>>           return webdriver.Firefox()
>> +    elif browser == 'marionette':
>> +        capabilities = DesiredCapabilities.FIREFOX
>> +        capabilities['marionette'] = True
>> +        return webdriver.Firefox(capabilities=capabilities)
>>       elif browser == 'ie':
>>           return webdriver.Ie()
>>       elif browser == 'phantomjs':
>>
>
> Ping on these two patches.
>
> Thanks,
>
> Michael
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--94eb2c05610eb26253053821d2ea
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
0 July 2016 at 16:55, Michael Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:=
michael.g.wood@intel.com" target=3D"_blank">michael.g.wood@intel.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><di=
v class=3D"h5">On 17/06/16 18:52, Michael Wood wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com" target=3D"=
_blank">elliot.smith@intel.com</a>&gt;<br>
<br>
For the latest Firefox versions, WebDriver requires a download of a<br>
separate binary and an additional capability to be defined on it.<br>
<br>
Modify our tests so that when &quot;marionette&quot; is set as the browser,=
<br>
this capability is defined on the Firefox driver. Also add a note to the<br=
>
README about the additional installation steps required.<br></blockquote></=
div></div></blockquote><div><br></div><div>Note that I resubmitted a rebase=
d version of these patches, as changes on toaster-next mean that this versi=
on won&#39;t apply.</div><div><br></div><div>Elliot</div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div cla=
ss=3D"h5"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com" t=
arget=3D"_blank">elliot.smith@intel.com</a>&gt;<br>
Signed-off-by: Michael Wood &lt;<a href=3D"mailto:michael.g.wood@intel.com"=
 target=3D"_blank">michael.g.wood@intel.com</a>&gt;<br>
---<br>
=C2=A0 lib/toaster/tests/browser/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 19 +++++++++++++++++--<br>
=C2=A0 lib/toaster/tests/browser/selenium_helpers.py |=C2=A0 5 +++++<br>
=C2=A0 2 files changed, 22 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/toaster/tests/browser/README b/lib/toaster/tests/browser/R=
EADME<br>
index f57154e..969f06c 100644<br>
--- a/lib/toaster/tests/browser/README<br>
+++ b/lib/toaster/tests/browser/README<br>
@@ -24,15 +24,30 @@ To run tests against PhantomJS (headless):<br>
=C2=A0 * On *nix systems, put phantomjs on PATH<br>
=C2=A0 * Not tested on Windows<br>
=C2=A0 -Firefox should work without requiring additional software to be ins=
talled.<br>
+To run tests against Firefox, you may need to install the Marionette drive=
r,<br>
+depending on how new your version of Firefox is. One clue that you need to=
 do<br>
+this is if you see an exception like:<br>
=C2=A0 -The test case will instantiate a Selenium driver set by the<br>
+=C2=A0 selenium.common.exceptions.WebDriverException: Message: The browser=
<br>
+=C2=A0 appears to have exited before we could connect. If you specified<br=
>
+=C2=A0 a log_file in the FirefoxBinary constructor, check it for details.<=
br>
+<br>
+See <a href=3D"https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marione=
tte/WebDriver" rel=3D"noreferrer" target=3D"_blank">https://developer.mozil=
la.org/en-US/docs/Mozilla/QA/Marionette/WebDriver</a><br>
+for installation instructions. Ensure that the Marionette executable (rena=
med<br>
+as wires on Linux or wires.exe on Windows) is on your PATH; and use &quot;=
marionette&quot;<br>
+as the browser string passed via TOASTER_TESTS_BROWSER (see below).<br>
+<br>
+(Note: The Toaster tests have been checked against Firefox 47 with the<br>
+Marionette driver.)<br>
+<br>
+The test cases will instantiate a Selenium driver set by the<br>
=C2=A0 TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not=
 specified.<br>
=C2=A0 =C2=A0 Available drivers:<br>
=C2=A0 =C2=A0 * chrome (default)<br>
=C2=A0 * firefox<br>
+* marionette (for newer Firefoxes)<br>
=C2=A0 * ie<br>
=C2=A0 * phantomjs<br>
=C2=A0 diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toa=
ster/tests/browser/selenium_helpers.py<br>
index 54db2e8..000937f 100644<br>
--- a/lib/toaster/tests/browser/selenium_helpers.py<br>
+++ b/lib/toaster/tests/browser/selenium_helpers.py<br>
@@ -34,6 +34,7 @@ import time<br>
=C2=A0 from django.contrib.staticfiles.testing import StaticLiveServerTestC=
ase<br>
=C2=A0 from selenium import webdriver<br>
=C2=A0 from selenium.webdriver.support.ui import WebDriverWait<br>
+from selenium.webdriver.common.desired_capabilities import DesiredCapabili=
ties<br>
=C2=A0 from selenium.common.exceptions import NoSuchElementException, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 StaleElementReferenceException, TimeoutE=
xception<br>
=C2=A0 @@ -49,6 +50,10 @@ def create_selenium_driver(browser=3D&#39;chrome&=
#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 elif browser =3D=3D &#39;firefox&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Firefox()<br>
+=C2=A0 =C2=A0 elif browser =3D=3D &#39;marionette&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 capabilities =3D DesiredCapabilities.FIREFOX<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 capabilities[&#39;marionette&#39;] =3D True<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Firefox(capabilities=3Dcapabi=
lities)<br>
=C2=A0 =C2=A0 =C2=A0 elif browser =3D=3D &#39;ie&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Ie()<br>
=C2=A0 =C2=A0 =C2=A0 elif browser =3D=3D &#39;phantomjs&#39;:<br>
</blockquote>
<br></div></div>
Ping on these two patches.<br>
<br>
Thanks,<br>
<br>
Michael<div class=3D"HOEnZb"><div class=3D"h5"><br>
---------------------------------------------------------------------<br>
Intel Corporation (UK) Limited<br>
Registered No. 1134945 (England)<br>
Registered Office: Pipers Way, Swindon SN3 1RJ<br>
VAT No: 860 2173 47<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div>Elliot Smith<br>Software Engineer<br>Intel Open Source Techno=
logy Centre</div></div></div>
</div></div>

--94eb2c05610eb26253053821d2ea--
