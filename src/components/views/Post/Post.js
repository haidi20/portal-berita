import React, {useEffect, useState} from 'react';

import './style.css';

import useApi from '../../hooks/api';

import Card from '../../materials/Card';

import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import SearchIcon from "@material-ui/icons/Search";
import TextField from '@material-ui/core/TextField';
import { makeStyles } from '@material-ui/core/styles';
import CircularProgress from '@material-ui/core/CircularProgress';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles((theme) => ({
    margin: {
        paddingTop: 20,
        textAlign: 'center',
    },
    paper: {
        margin: 'auto',
        maxWidth: 500,
        padding: theme.spacing(2),
        backgroundColor: '#FFFFF',
    },
    title: {
        flexGrow: 1,
        textAlign: 'center',
    },
  }));

const styled = {
    header: {
        height: 140,
        paddingTop: 5,
        textAlign: 'center',
    },
    content: {
        height: 600,
    },
    positionLoading: {
        textAlign: 'center',  
    },
    loading: {
        width: 60,
        height: 60,
        marginTop: 100,
    },
    appBar: {
        backgroundColor: '#2B9EF3',
    }
}

const Post = props => {
    const classes = useStyles();
    const {
        data, loading, 
        fetchContent, fetchImage, 
        fetchTime, fetchTitle,
    } = useApi();

    // useEffect(() => {
    //     window.onscroll = function(ev) {
    //         console.log(window.scrollY);
    //     };
    // }, []);

    return (
        <div>
            <Grid container spacing={1}>
                <AppBar position="static" style={styled.appBar}>
                    <Toolbar>
                    <Typography variant="h6" className={classes.title}>
                        Portal Berita
                    </Typography>
                    </Toolbar>
                </AppBar>
                <Grid item md={3} xs={12}></Grid>
                <Grid item md={6} xs={12}>
                    <Paper>
                        <div className={classes.margin}>
                            <Grid container spacing={1} alignItems="flex-end">
                                <Grid item md={4} xs={2} sm={4}></Grid>
                                <Grid item>
                                    <SearchIcon />
                                </Grid>
                                <Grid item>
                                    <TextField 
                                        fullWidth={true}
                                        label="Search" 
                                        id="input-with-icon-grid" 
                                        onKeyUp={e => console.log(e.target.value)}
                                    />
                                </Grid>
                            </Grid>
                        </div>
                        <div style={styled.content}>
                            { loading 
                                ? <div style={styled.positionLoading} > <CircularProgress style={styled.loading} /> </div>
                                : data.map((item, index) => {
                                    let time    = fetchTime(item);
                                    let title   = fetchTitle(item);
                                    let image   = fetchImage(item);
                                    let content = fetchContent(item);

                                    return <Card
                                        key={index} 
                                        time={time}
                                        image={image}
                                        title={title} 
                                        content={content}
                                    />    
                                }) 
                            }
                        </div>
                    </Paper>
                </Grid>
            </Grid>
        </div>
    )
}

export default Post;