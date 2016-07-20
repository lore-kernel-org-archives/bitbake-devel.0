Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 559C3606A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 15:55:27 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id f65so181313019wmi.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=odstFt+y9CHEyjzqjhmUS23/EY1b0xNF9lAxNwL+T1w=;
	b=zuEKxhpCplzx3bIIUBmj4ZBubSDN9BVbSkq+muo79YxiwhYO584VAT35qjGF4Zo0oz
	xB0a8BvjP8dAZEHEBNwE73rjcKMOIavugNCm/EK8oyQl+BmKa36ItsN3hYx3VCQ+OuCh
	XNdhPGZG7XMz7wKf3ksQBs3VkP1G8HVqzXerjnKFiyNUQj6vZyq7oxPPR4277TwmUZvh
	fWuzY8NSmU53nFxZFevQOgz2LAsi8zZvl6xKdpK781k8kaGv+b37A5vIbZgF8mp7OsoB
	0a76rRRv4DuABEW1VU+3hVumpkHLH7/MrYA25cIi7W2HTRS3XEqyfK/iCs1MUm5pmU5w
	QdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=odstFt+y9CHEyjzqjhmUS23/EY1b0xNF9lAxNwL+T1w=;
	b=RpEhoYwRGCZkl6MiyMTAZfQoW9yrOq7lW2R4K4q21lyMSF6cIOu40IuZAwfK0TEWPa
	ho0zXewq6fKjDVqkiFLr5oKVI5yv1r6crGKDkSZ1B4GRewM4IQREpny2GuTzxnW6UqaE
	YEk7sKByE7Q2csbg4sTQr78IICzgrHl4I/PhIiPeAAAo6FxYViNlvylmszEhwqMWgIIo
	z4vwL+MIjYHAijXL5qL0pPebZx+AT0qepPPD8eFQZ+qLLkvsE0fwouLnB/eah5McU/jA
	sfKidgp8JBWixsVY/A8ePtGYiNblN4ijsNsZsQyIjCIeH+vMrY6WM/4FRdIbaXIO26ny
	8O2g==
X-Gm-Message-State: ALyK8tJx7xytp6sBsOvT1azJS+BPLHWM5OtP4dkwd5Pj1S5v+3vTqgonPq0ftUvk52Ts7eoI
X-Received: by 10.28.157.214 with SMTP id g205mr12609911wme.34.1469030127870; 
	Wed, 20 Jul 2016 08:55:27 -0700 (PDT)
Received: from [192.168.0.78]
	(host109-153-40-30.range109-153.btcentralplus.com. [109.153.40.30])
	by smtp.googlemail.com with ESMTPSA id
	zb5sm1908032wjc.44.2016.07.20.08.55.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 20 Jul 2016 08:55:26 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <1466185971-18537-1-git-send-email-michael.g.wood@intel.com>
	<1466185971-18537-2-git-send-email-michael.g.wood@intel.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <578F9EEE.9000708@intel.com>
Date: Wed, 20 Jul 2016 16:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1466185971-18537-2-git-send-email-michael.g.wood@intel.com>
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
X-List-Received-Date: Wed, 20 Jul 2016 15:55:31 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/16 18:52, Michael Wood wrote:
> From: Elliot Smith <elliot.smith@intel.com>
>
> For the latest Firefox versions, WebDriver requires a download of a
> separate binary and an additional capability to be defined on it.
>
> Modify our tests so that when "marionette" is set as the browser,
> this capability is defined on the Firefox driver. Also add a note to the
> README about the additional installation steps required.
>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> ---
>   lib/toaster/tests/browser/README              | 19 +++++++++++++++++--
>   lib/toaster/tests/browser/selenium_helpers.py |  5 +++++
>   2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/lib/toaster/tests/browser/README b/lib/toaster/tests/browser/README
> index f57154e..969f06c 100644
> --- a/lib/toaster/tests/browser/README
> +++ b/lib/toaster/tests/browser/README
> @@ -24,15 +24,30 @@ To run tests against PhantomJS (headless):
>   * On *nix systems, put phantomjs on PATH
>   * Not tested on Windows
>   
> -Firefox should work without requiring additional software to be installed.
> +To run tests against Firefox, you may need to install the Marionette driver,
> +depending on how new your version of Firefox is. One clue that you need to do
> +this is if you see an exception like:
>   
> -The test case will instantiate a Selenium driver set by the
> +  selenium.common.exceptions.WebDriverException: Message: The browser
> +  appears to have exited before we could connect. If you specified
> +  a log_file in the FirefoxBinary constructor, check it for details.
> +
> +See https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette/WebDriver
> +for installation instructions. Ensure that the Marionette executable (renamed
> +as wires on Linux or wires.exe on Windows) is on your PATH; and use "marionette"
> +as the browser string passed via TOASTER_TESTS_BROWSER (see below).
> +
> +(Note: The Toaster tests have been checked against Firefox 47 with the
> +Marionette driver.)
> +
> +The test cases will instantiate a Selenium driver set by the
>   TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not specified.
>   
>   Available drivers:
>   
>   * chrome (default)
>   * firefox
> +* marionette (for newer Firefoxes)
>   * ie
>   * phantomjs
>   
> diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
> index 54db2e8..000937f 100644
> --- a/lib/toaster/tests/browser/selenium_helpers.py
> +++ b/lib/toaster/tests/browser/selenium_helpers.py
> @@ -34,6 +34,7 @@ import time
>   from django.contrib.staticfiles.testing import StaticLiveServerTestCase
>   from selenium import webdriver
>   from selenium.webdriver.support.ui import WebDriverWait
> +from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
>   from selenium.common.exceptions import NoSuchElementException, \
>           StaleElementReferenceException, TimeoutException
>   
> @@ -49,6 +50,10 @@ def create_selenium_driver(browser='chrome'):
>           )
>       elif browser == 'firefox':
>           return webdriver.Firefox()
> +    elif browser == 'marionette':
> +        capabilities = DesiredCapabilities.FIREFOX
> +        capabilities['marionette'] = True
> +        return webdriver.Firefox(capabilities=capabilities)
>       elif browser == 'ie':
>           return webdriver.Ie()
>       elif browser == 'phantomjs':

Ping on these two patches.

Thanks,

Michael

