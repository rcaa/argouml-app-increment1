package org.argouml.guillemets;

import java.awt.GridBagConstraints;

import javax.swing.JPanel;

import org.argouml.kernel.ProjectSettings;
import org.argouml.notation.NotationSettings;
import org.argouml.notation.ui.SettingsTabNotation;
import org.argouml.util.AroundAdvice;
import org.argouml.util.Driver;

public privileged aspect GuillemetsDynamic extends GuillemetsFeature {

    pointcut driver() : if(Driver.getDriver("argo.notation.guillemots").equals("true"));

    pointcut createCheckBoxGuillemotsHook(JPanel settings,
            GridBagConstraints constraints, SettingsTabNotation cthis) 
        : GuillemetsFeature.createCheckBoxGuillemotsHook(settings, constraints, cthis) && driver();

    pointcut isUseGuillemets(NotationSettings cthis) 
    : GuillemetsFeature.isUseGuillemets(cthis) && driver();

    pointcut getUseGuillemotsValue(ProjectSettings cthis) 
    : GuillemetsFeature.getUseGuillemotsValue(cthis) && driver();

    void around() : adviceexecution() && within(org.argouml.guillemets.GuillemetsFeature) && !@annotation(AroundAdvice) {
        if (Driver.getDriver("argo.notation.guillemots").equals("true")) {
            proceed();
        }
    }
}