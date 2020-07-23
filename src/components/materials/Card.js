import React from 'react';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import { makeStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import ButtonBase from '@material-ui/core/ButtonBase';
import Hidden from '@material-ui/core/Hidden';

import { Markup } from 'interweave';

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    margin: 'auto',
    padding: theme.spacing(2),
  },
  imageMobile: {
    width: 80,
    paddingTop: 2,
  },
  imgMobile: {
    height: 70,
    margin: 'auto',
    borderRadius: 10,
    display: 'block',
    maxWidth: '100%',
  },
  imageWeb: {
    width: 128,
  },
  imgWeb: {
    height: 90,
    margin: 'auto',
    display: 'block',
    borderRadius: 10,
    maxWidth: '100%',
  }
}));

const styled = {
  time: {
    fontSize: 12,
  }
}

export default function ComplexGrid(props) {
  const classes = useStyles();

  return (
    <Grid container spacing={2}>
      {/* image mobile */}
      <Hidden smUp>
        <Grid item xs={3}>
          <ButtonBase className={classes.imageMobile}>
            <img className={classes.imgMobile} alt="complex" src={props.image} />
          </ButtonBase>
        </Grid>
      </Hidden>
      {/* content mobile */}
      <Hidden smUp>
        <Grid item xs={9} sm container>
          <Grid item xs container direction="column" spacing={2}>
            <Grid item xs>
              <Typography gutterBottom style={{marginBottom: 0}}>
                {props.title.mobile}
              </Typography>
              <div style={styled.time}>
                  {props.time}
                </div>
              <Typography variant="body2" gutterBottom style={{marginTop: 9}}>
                  {props.content.mobile}
              </Typography>
            </Grid>
          </Grid>
        </Grid>
      </Hidden>
      {/* image web */}
      <Hidden xsDown>
        <Grid item>
          <ButtonBase className={classes.imageWeb}>
            <img className={classes.imgWeb} alt="complex" src={props.image} />
          </ButtonBase>
        </Grid>
      </Hidden>
      {/* content web */}
      <Hidden xsDown>
        <Grid item xs={9} sm container>
          <Grid item xs container direction="column" spacing={2}>
            <Grid item xs>
              <Typography gutterBottom variant="subtitle1">
                {props.title.web} <br />
                {props.time}
              </Typography>
              <Typography variant="body2" gutterBottom>
                  {props.content.web}
              </Typography>
            </Grid>
          </Grid>
        </Grid>
      </Hidden>
    </Grid>
  );
}

