Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2EC9875C61
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jan 2017 17:04:54 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP; 24 Jan 2017 09:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,278,1477983600"; 
	d="asc'?scan'208";a="56980776"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.128.122])
	([10.219.128.122])
	by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2017 09:04:54 -0800
To: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
References: <cover.1485212879.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
	<170ecdc0502ef8509b1d513a7522606ed870278a.1485212879.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <588789EA.3090102@linux.intel.com>
Date: Tue, 24 Jan 2017 11:07:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <170ecdc0502ef8509b1d513a7522606ed870278a.1485212879.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: Re: [[selftest][PATCH] 1/2] bitbake: tests: create unit tests for event module
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
X-List-Received-Date: Tue, 24 Jan 2017 17:04:55 -0000
X-Groupsio-MsgNum: 8389
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="r5mNwxFMNJXmr3IjqwRnJ0tcWOOCtgqGm"

--r5mNwxFMNJXmr3IjqwRnJ0tcWOOCtgqGm
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Jair,

At first glance your tests are good, there are some comments below,

Cheers,
	alimon

On 01/23/2017 05:25 PM, Jair Gonzalez wrote:
> This change adds a new unit test module (bb.tests.event)
> for bitbake event.
> It includes the following items:
>=20
> - Client and server stubs setup
> - Testing the module's main functions including:
> 	- get_class_handlers
> 	- set_class_handlers
> 	- clean_class_handlers
> 	- enable_threadlock
> 	- disable_threadlock
> 	- get_handlers
> 	- set_handlers
> 	- execute_handler
> 	- fire_class_handlers
> 	- print_ui_queue
> 	- fire_ui_handlers
> 	- fire
> 	- fire_from_worker
> 	- register
> 	- remove
> 	- register_UIHhandler
> 	- unregister_UIHhandler
> - Testing event handling using:
> 	- class Event(object)
> 	- class OperationStarted(Event)
> 	- class OperationCompleted(Event)
> 	- class OperationProgress(Event)
> 	- class ConfigParsed(Event)
>=20
> [YOCTO #10368]
>=20
> Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.i=
ntel.com>
> ---
>  bitbake/lib/bb/tests/event.py | 324 ++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 324 insertions(+)
>  create mode 100644 bitbake/lib/bb/tests/event.py
>=20
> diff --git a/bitbake/lib/bb/tests/event.py b/bitbake/lib/bb/tests/event=
=2Epy
> new file mode 100644
> index 0000000..58846ee
> --- /dev/null
> +++ b/bitbake/lib/bb/tests/event.py
> @@ -0,0 +1,324 @@
> +# ex:ts=3D4:sw=3D4:sts=3D4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +#
> +# BitBake Tests for the Event implementation (event.py)
> +#
> +# Copyright (C) 2017 Intel

Here is missing the Corporation.

Copyright (C) 2017 Intel Corporation

> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License al=
ong
> +# with this program; if not, write to the Free Software Foundation, In=
c.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +import unittest
> +import bb
> +import logging
> +import bb.compat
> +import bb.event
> +import importlib
> +import threading
> +import time
> +from unittest.mock import Mock
> +
> +
> +class EventQueueStub():
> +    """ Class used as specification for UI event handler queue stub ob=
jects """
> +    def __init__(self):
> +        return
> +
> +    def send(self, event):
> +        return
> +
> +
> +class PickleEventQueueStub():
> +    """ Class used as specification for UI event handler queue stub ob=
jects
> +        with sendpickle method """
> +    def __init__(self):
> +        return
> +
> +    def sendpickle(self, pickled_event):
> +        return
> +
> +
> +class UIClientStub():
> +    """ Class used as specification for UI event handler stub objects =
"""
> +    def __init__(self):
> +        self.event =3D None
> +
> +
> +class EventHandlingTest(unittest.TestCase):
> +    """ Event handling test class """
> +    _threadlock_test_calls =3D []
> +
> +    def setUp(self):
> +        self._test_process =3D Mock()
> +        ui_client1 =3D UIClientStub()
> +        ui_client2 =3D UIClientStub()
> +        self._test_ui1 =3D Mock(wraps=3Dui_client1)
> +        self._test_ui2 =3D Mock(wraps=3Dui_client2)
> +        importlib.reload(bb.event)
> +
> +    def _create_test_handlers(self):
> +        """ Method used to create a test handler ordered dictionary ""=
"
> +        test_handlers =3D bb.compat.OrderedDict()
> +        test_handlers["handler1"] =3D self._test_process.handler1
> +        test_handlers["handler2"] =3D self._test_process.handler2
> +        return test_handlers
> +
> +    def test_class_handlers(self):
> +        """ Test set_class_handlers and get_class_handlers methods """=

> +        test_handlers =3D self._create_test_handlers()
> +        bb.event.set_class_handlers(test_handlers)
> +        self.assertEqual(test_handlers,
> +                         bb.event.get_class_handlers())

Since the bb.event set_class_handlers and clean_handlers are simple, i
don't know if there needs of a test case. The same in the related code
below.


> +
> +    def test_handlers(self):
> +        """ Test set_handlers and get_handlers """
> +        test_handlers =3D self._create_test_handlers()
> +        bb.event.set_handlers(test_handlers)
> +        self.assertEqual(test_handlers,
> +                         bb.event.get_handlers())
> +
> +    def test_clean_class_handlers(self):
> +        """ Test clean_class_handlers method """
> +        cleanDict =3D bb.compat.OrderedDict()
> +        self.assertEqual(cleanDict,
> +                         bb.event.clean_class_handlers())
> +
> +    def test_register(self):
> +        """ Test register method for class handlers """
> +        result =3D bb.event.register("handler", self._test_process.han=
dler)
> +        self.assertEqual(result, bb.event.Registered)
> +        handlers_dict =3D bb.event.get_class_handlers()
> +        self.assertIn("handler", handlers_dict)
> +
> +    def test_already_registered(self):
> +        """ Test detection of an already registed class handler """
> +        bb.event.register("handler", self._test_process.handler)
> +        handlers_dict =3D bb.event.get_class_handlers()
> +        self.assertIn("handler", handlers_dict)
> +        result =3D bb.event.register("handler", self._test_process.han=
dler)
> +        self.assertEqual(result, bb.event.AlreadyRegistered)
> +
> +    def test_register_from_string(self):
> +        """ Test register method receiving code in string """
> +        result =3D bb.event.register("string_handler", "    return Tru=
e")
> +        self.assertEqual(result, bb.event.Registered)
> +        handlers_dict =3D bb.event.get_class_handlers()
> +        self.assertIn("string_handler", handlers_dict)
> +
> +    def test_register_with_mask(self):
> +        """ Test register method with event masking """
> +        mask =3D ["bb.event.OperationStarted",
> +                "bb.event.OperationCompleted"]
> +        result =3D bb.event.register("event_handler",
> +                                   self._test_process.event_handler,
> +                                   mask)
> +        self.assertEqual(result, bb.event.Registered)
> +        handlers_dict =3D bb.event.get_class_handlers()
> +        self.assertIn("event_handler", handlers_dict)
> +
> +    def test_remove(self):
> +        """ Test remove method for class handlers """
> +        test_handlers =3D self._create_test_handlers()
> +        bb.event.set_class_handlers(test_handlers)
> +        count =3D len(test_handlers)
> +        bb.event.remove("handler1", None)
> +        self.assertEqual(len(test_handlers), count - 1)
> +        with self.assertRaises(KeyError):
> +            bb.event.remove("handler1", None)
> +
> +    def test_execute_handler(self):
> +        """ Test execute_handler method for class handlers """
> +        mask =3D ["bb.event.OperationProgress"]
> +        result =3D bb.event.register("event_handler",
> +                                   self._test_process.event_handler,
> +                                   mask)
> +        self.assertEqual(result, bb.event.Registered)
> +        event =3D bb.event.OperationProgress(current=3D10, total=3D100=
)
> +        bb.event.execute_handler("event_handler",
> +                                 self._test_process.event_handler,
> +                                 event,
> +                                 None)
> +        self._test_process.event_handler.assert_called_once_with(event=
)
> +
> +    def test_fire_class_handlers(self):
> +        """ Test fire_class_handlers method """
> +        mask =3D ["bb.event.OperationStarted"]
> +        result =3D bb.event.register("event_handler1",
> +                                   self._test_process.event_handler1,
> +                                   mask)
> +        self.assertEqual(result, bb.event.Registered)
> +        result =3D bb.event.register("event_handler2",
> +                                   self._test_process.event_handler2,
> +                                   "*")
> +        event1 =3D bb.event.OperationStarted()
> +        event2 =3D bb.event.OperationCompleted(total=3D123)
> +        bb.event.fire_class_handlers(event1, None)
> +        bb.event.fire_class_handlers(event2, None)
> +        bb.event.fire_class_handlers(event2, None)
> +        self.assertEqual(self._test_process.event_handler1.call_count,=
 1)
> +        self.assertEqual(self._test_process.event_handler2.call_count,=
 3)

You count for number of events arrived, will be good if you can test
about what type of event arrived. The same in the related code below.

> +
> +    def test_change_handler_event_mapping(self):
> +        """ Test changing the event mapping for class handlers """
> +        # register handler for all events
> +        result =3D bb.event.register("event_handler1",
> +                                   self._test_process.event_handler1,
> +                                   "*")
> +        self.assertEqual(result, bb.event.Registered)
> +        event1 =3D bb.event.OperationStarted()
> +        event2 =3D bb.event.OperationCompleted(total=3D123)
> +        bb.event.fire_class_handlers(event1, None)
> +        bb.event.fire_class_handlers(event2, None)
> +        self.assertEqual(self._test_process.event_handler1.call_count,=
 2)
> +
> +        # unregister handler and register it only for OperationStarted=

> +        result =3D bb.event.remove("event_handler1",
> +                                 self._test_process.event_handler1)
> +        mask =3D ["bb.event.OperationStarted"]
> +        result =3D bb.event.register("event_handler1",
> +                                   self._test_process.event_handler1,
> +                                   mask)
> +        self.assertEqual(result, bb.event.Registered)
> +        bb.event.fire_class_handlers(event1, None)
> +        bb.event.fire_class_handlers(event2, None)
> +        self.assertEqual(self._test_process.event_handler1.call_count,=
 3)
> +
> +    def test_register_UIHhandler(self):
> +        """ Test register_UIHhandler method """
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +
> +    def test_UIHhandler_already_registered(self):
> +        """ Test registering an UIHhandler already existing """
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 2)
> +
> +    def test_unregister_UIHhandler(self):
> +        """ Test unregister_UIHhandler method """
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +        result =3D bb.event.unregister_UIHhandler(1)
> +        self.assertIs(result, None)
> +
> +    def test_fire_ui_handlers(self):
> +        """ Test fire_ui_handlers method """
> +        self._test_ui1.event =3D Mock(spec_set=3DEventQueueStub)
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +        self._test_ui2.event =3D Mock(spec_set=3DPickleEventQueueStub)=

> +        result =3D bb.event.register_UIHhandler(self._test_ui2, mainui=
=3DTrue)
> +        self.assertEqual(result, 2)
> +        bb.event.fire_ui_handlers(bb.event.OperationStarted(), None)
> +        self.assertEqual(self._test_ui1.event.send.call_count, 1)
> +        self.assertEqual(self._test_ui2.event.sendpickle.call_count, 1=
)
> +
> +    def test_fire(self):
> +        """ Test fire method used to trigger class and ui event handle=
rs """
> +        mask =3D ["bb.event.ConfigParsed"]
> +        result =3D bb.event.register("event_handler1",
> +                                   self._test_process.event_handler1,
> +                                   mask)
> +
> +        self._test_ui1.event =3D Mock(spec_set=3DEventQueueStub)
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +
> +        event1 =3D bb.event.ConfigParsed()
> +        bb.event.fire(event1, None)
> +        self.assertEqual(self._test_process.event_handler1.call_count,=
 1)
> +        self.assertEqual(self._test_ui1.event.send.call_count, 1)
> +
> +    def test_fire_from_worker(self):
> +        """ Test fire_from_worker method """
> +        self._test_ui1.event =3D Mock(spec_set=3DEventQueueStub)
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +        bb.event.fire_from_worker(bb.event.ConfigParsed(), None)
> +        self.assertEqual(self._test_ui1.event.send.call_count, 1)
> +
> +    def test_print_ui_queue(self):
> +        """ Test print_ui_queue method """
> +        event1 =3D bb.event.OperationStarted()
> +        event2 =3D bb.event.OperationCompleted(total=3D123)
> +        bb.event.fire(event1, None)
> +        bb.event.fire(event2, None)
> +        logger =3D logging.getLogger("BitBake")
> +        logger.addHandler(bb.event.LogHandler())
> +        logger.info("Test info LogRecord")
> +        logger.warning("Test warning LogRecord")
> +        with self.assertLogs("BitBake", level=3D"INFO") as cm:
> +            bb.event.print_ui_queue()
> +        self.assertEqual(cm.output,
> +                         ["INFO:BitBake:Test info LogRecord",
> +                          "WARNING:BitBake:Test warning LogRecord"])
> +
> +    def _set_threadlock_test_mockups(self):
> +        """ Create test mockups used in enable and disable threadlock
> +            tests """
> +        def ui1_event_send(event):
> +            self._threadlock_test_calls.append(1)
> +            time.sleep(0.2)
> +
> +        def ui2_event_send(event):
> +            self._threadlock_test_calls.append(2)
> +            time.sleep(0.2)
> +
> +        self._threadlock_test_calls =3D []
> +        self._test_ui1.event =3D EventQueueStub()
> +        self._test_ui1.event.send =3D ui1_event_send
> +        result =3D bb.event.register_UIHhandler(self._test_ui1, mainui=
=3DTrue)
> +        self.assertEqual(result, 1)
> +        self._test_ui2.event =3D EventQueueStub()
> +        self._test_ui2.event.send =3D ui2_event_send
> +        result =3D bb.event.register_UIHhandler(self._test_ui2, mainui=
=3DTrue)
> +        self.assertEqual(result, 2)
> +
> +    def _set_and_run_threadlock_test_workers(self):
> +        """ Create and run workers used in enable and disable threadlo=
ck
> +            tests """
> +        worker1 =3D threading.Thread(target=3Dself._thread_lock_test_w=
orker)
> +        worker2 =3D threading.Thread(target=3Dself._thread_lock_test_w=
orker)
> +        worker1.start()
> +        time.sleep(0.01)
> +        worker2.start()
> +        time.sleep(0.2)
> +        worker1.join()
> +        worker2.join()
> +
> +    def _thread_lock_test_worker(self):
> +        """ Worker used to create race conditions for enable and disab=
le
> +            threadlocks tests """
> +        bb.event.fire(bb.event.ConfigParsed(), None)
> +        time.sleep(0.02)
> +        bb.event.fire(bb.event.OperationStarted(), None)
> +
> +    def test_enable_threadlock(self):
> +        """ Test enable_threadlock method """
> +        self._set_threadlock_test_mockups()
> +        bb.event.enable_threadlock()
> +        self._set_and_run_threadlock_test_workers()
> +        # Calls to UI Handlers should be in order
> +        self.assertEqual(self._threadlock_test_calls,
> +                         [1, 2, 1, 2, 1, 2, 1, 2])

This kind of test of inputs given by certain threads don't guarantee the
order it depends on Python thread scheduler so i suggest to test for a
number of thread1 of inputs and thread2 inputs.  Same below.

> +
> +    def test_disable_threadlock(self):
> +        """ Test disable_threadlock method """
> +        self._set_threadlock_test_mockups()
> +        bb.event.disable_threadlock()
> +        self._set_and_run_threadlock_test_workers()
> +        # Calls to UI Handlers should be interwined together
> +        self.assertEqual(self._threadlock_test_calls,
> +                         [1, 1, 2, 2, 1, 1, 2, 2])
>=20


--r5mNwxFMNJXmr3IjqwRnJ0tcWOOCtgqGm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYh4nsAAoJEGJqcE9h3glg5yQP/iIxbG4si53esBmQAEUh0rsF
UPvKxeVWCbSEyrzRnR9BXK16GTC0PyRTUG1dMfVZjNMyxou/KuPgv8fhhAEzuMKc
yiIEn2TWYDDv58LUr+ePGIJuxqlQ1GRiWZ7OVk17UOSLMgTxPdJzX/AUl3eWS4Jw
9q6aam+plJNv2r7SdOrFotZKV7t4e3FnOiDal4Tbsyi6loj0HCNAUnW0wmFu7LDk
09WRPInjNWHegk0qBEdvBbVfcq59v+jmfqJC6v9MRTmVeK7pR1cx0zBpHazZnxE8
ZD4Nyx/aftY6/HF74VMspQeMpY4aul7APu84CfGQjylGTaZHBG+Q3132qHcOndyU
EaQH8tzzGVzxcUR6pXf7dFn3kr6leDH8zVcMzaFkVKlVH9tRmJJJTsiW9jVyQDxf
6RjNkzE6kjoLYQf7ADAhYd077fMWVCB46t/WORDc1KyVeS+ZD+1OZeI/0nK1LZyW
rK+nSxoNF7mMLMeRDuOptaIhuH7KZeUmb8TOVCM8y3XBhJ0bhciv7qEzCu5aX3vO
WY1I+0Ir3WbbxCoMFjq2Y9fgl3Z0OGMIC8QE0hFoIfwREbbX4ZU1wDAQHM8VEzKd
ce29v9xAmcHs95DiSgD4X5j173Fgsz3Dkmv6Rp0bZQor4r3dApQ3XURNiIHf9EVK
/pDw02DIcoaZQf5tjAKb
=DOPf
-----END PGP SIGNATURE-----

--r5mNwxFMNJXmr3IjqwRnJ0tcWOOCtgqGm--
